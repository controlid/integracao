package br.com.controlid.idbiotest;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.hardware.usb.UsbManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import br.com.controlid.idbio.IDBio;
import br.com.controlid.idbio.communication.IDDeviceListeners;
import br.com.controlid.idbio.enums.EnumRetCodes;
import br.com.controlid.idbio.enums.EnumParam;
import br.com.controlid.idbio.enums.EnumStatus;
import br.com.controlid.idbio.objects.BaseReturn;
import br.com.controlid.idbio.objects.ImageData;
import br.com.controlid.idbio.objects.ImageTemplateData;
import br.com.controlid.idbio.objects.MatchData;


/**
 * MainActivityIndividualListeners
 *
 * @author Elian Medeiros
 * @version 1.0.0
 * @since Release 08/18
 */
public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    // Controller

    private ProgressDialog progressDialog;

    private Dialog dialog;
    private View btn001;
    private View btn004;
    private View btn005;
    private View btn006;

    private String template_finger;
    private ImageView image_bio;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        try { getSupportActionBar().hide(); } catch(Exception e) { /**/ } // Remove action bar

        setContentView(R.layout.activity_main);

        IDBio.config();

        btn001 = findViewById(R.id.btn_001);
        btn001.setOnClickListener(this);

        btn004 = findViewById(R.id.btn_004);
        btn004.setOnClickListener(this);
        btn004.setVisibility(View.GONE);

        btn005 = findViewById(R.id.btn_005);
        btn005.setOnClickListener(this);
        btn005.setVisibility(View.GONE);

        btn006 = findViewById(R.id.btn_006);
        btn006.setOnClickListener(this);

        image_bio = findViewById(R.id.image_bio);

        IDBio.getInstance().startConnection(getApplicationContext());
        onNewIntent(getIntent());

        final View iconConnect = findViewById(R.id.icon_connect);
        final View iconDisconnect = findViewById(R.id.icon_disconnect);
        final TextView connectionTV = findViewById(R.id.status_connection);

        if(IDBio.getInstance().isConnected()) {
            iconConnect.setVisibility(View.VISIBLE);
            iconDisconnect.setVisibility(View.GONE);
            connectionTV.setText(EnumStatus.CONNECTED.toString());
        }
        else {
            iconConnect.setVisibility(View.GONE);
            iconDisconnect.setVisibility(View.VISIBLE);
            connectionTV.setText(EnumStatus.DISCONNECTED.toString());
        }

        // Example listener inline OnChangeConnection USB
        IDBio.getInstance().setOnChangeConnection(new IDDeviceListeners.OnChangeConnectionListener() {
            @Override
            public void status(EnumStatus enumSatStatus) {
                connectionTV.setText(enumSatStatus.toString());

                iconConnect.setVisibility((enumSatStatus.equals(EnumStatus.CONNECTED)) ? View.VISIBLE : View.GONE);
                iconDisconnect.setVisibility((enumSatStatus.equals(EnumStatus.CONNECTED)) ? View.GONE : View.VISIBLE);

                if(progressDialog != null)
                    if(progressDialog.isShowing())
                        showAlert(enumSatStatus.toString());
            }
        });
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);

        if(intent.getAction().equals(UsbManager.ACTION_USB_DEVICE_ATTACHED))
            IDBio.getInstance().startConnection(getApplicationContext());
    }

    @Override
    public void onClick(final View view) {
        AsyncRequest asyncRequest = new AsyncRequest();

        if(view.equals(btn001) || view.equals(btn005)) {
            asyncRequest.loadMessage = "Coloque seu dedo no leitor";
        }

        asyncRequest.execute(view);
    }

    private void closeLoading() {
        if(progressDialog != null)
            progressDialog.dismiss();
    }

    public void showAlert(String message) {
        this.closeLoading();

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(message.replace("|", "\n"));
        builder.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int arg1) {
                dialog.dismiss();
            }
        });
        AlertDialog alerta = builder.create();
        alerta.show();
    }

    public void openImageAlert(final ImageData image) {
        int width = (int) image.getWidth();
        int height = (int) image.getHeight();

        Bitmap imageBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        int position = 0;

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                final byte[] imgByte = image.getImg();
                if(position < imgByte.length) {
                    final int r = imgByte[position] & 0xff;
                    final int g = imgByte[position] & 0xff;
                    final int b = imgByte[position++] & 0xff;

                    imageBitmap.setPixel(x, y, Color.argb(255, r, g, b));
                }
            }
        }

        dialog = new Dialog(MainActivity.this);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setCancelable(false);
        dialog.setContentView(R.layout.finger_template);

        ImageView imageViewer = dialog.findViewById(R.id.image_viewer);
        imageViewer.setImageBitmap(imageBitmap);

        final Button cancelButton = dialog.findViewById(R.id.btn_cancel);
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });


        Button btnSave = dialog.findViewById(R.id.btn_save);
        TextView txQuality = dialog.findViewById(R.id.tx_quality);

        if(image instanceof ImageTemplateData) {
            image_bio.setImageBitmap(imageBitmap);
            txQuality.setText("Quality: " + ((ImageTemplateData) image).getQuality());
            btnSave.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dialog.dismiss();
                    btn004.setVisibility(View.VISIBLE);
                }
            });
        }
        else {
            txQuality.setVisibility(View.GONE);
            btnSave.setVisibility(View.GONE);
        }

        dialog.show();
    }




    @SuppressLint("StaticFieldLeak")
    private class AsyncRequest extends AsyncTask<Object, Void, BioResponse> {

        public String loadMessage;

        AsyncRequest() {
            super();
            this.loadMessage = getString(R.string.waiting);
        }

        @Override
        protected void onPreExecute(){
            progressDialog = ProgressDialog.show(MainActivity.this, null, this.loadMessage, true);
        }

        @Override
        protected BioResponse doInBackground(Object... params) {
            Object target = params[0];

            if(IDBio.getInstance().isConnected()) {

                if(target.equals(btn001)) {
                    return new BioResponse(target, IDBio.getInstance().CIDBIO_CaptureImageAndTemplate());
                }
                else if(target.equals(btn004)) {
                    return new BioResponse(target, IDBio.getInstance().CIDBIO_SaveTemplate(1, template_finger));
                }
                else if(target.equals(btn005)) {
                    return new BioResponse(target, IDBio.getInstance().CIDBIO_CaptureAndMatch(1));
                }
            }

            return null;
        }

        @Override
        protected void onPostExecute(BioResponse data){
            if(IDBio.getInstance().isConnected()) {
                closeLoading();

                if(data.target.equals(btn001)) {
                    template_finger = ((ImageTemplateData) data.data).getTemplate();
                }

                if(data.target.equals(btn001)) {
                    openImageAlert((ImageData) data.data);
                } else if(data.target.equals(btn004)) {
                    btn005.setVisibility(View.VISIBLE);
                    showAlert("Template salvo!");
                } else if(data.target.equals(btn005)) {
                    MatchData matchResult = ((MatchData) data.data);
                    if(matchResult.getCodRet() == EnumRetCodes.SUCCESS)
                        showAlert("Comparação realizada com sucesso. Nota: " + String.valueOf(matchResult.getScore()));
                    else {
                        showAlert("Comparação falhou: " + matchResult.getCodRet().getMessage());
                    }
                }
            }
            else {
                showAlert(getString(R.string.disconnected));
            }
        }
    }

    class BioResponse {
        public Object target;
        public BaseReturn data;

        BioResponse(Object target, BaseReturn data) {
            this.target = target;
            this.data = data;
        }
    }
}
