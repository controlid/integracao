package br.com.controlid.printidtest;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.hardware.usb.UsbManager;
import android.os.Handler;
import android.os.Looper;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

import br.com.controlid.printid.PrintID;
import br.com.controlid.printid.communication.IDDeviceListeners;
import br.com.controlid.printid.enums.EnumPosicaoCaracteresBarras;
import br.com.controlid.printid.enums.EnumQRCorrecaoErro;
import br.com.controlid.printid.enums.EnumQRModelo;
import br.com.controlid.printid.enums.EnumStatus;
import br.com.controlid.printid.enums.EnumTipoCodigoBarras;
import br.com.controlid.printid.enums.EnumTipoCorte;


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

    private View btn001;
    private View btn002;
    private View btn003;
    private View btn004;
    private View btn005;
    private View btn006;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        try { getSupportActionBar().hide(); } catch(Exception e) { /**/ } // Remove action bar

        setContentView(R.layout.activity_main);

        PrintID.config(getApplicationContext());

        btn001 = findViewById(R.id.btn_001);
        btn001.setOnClickListener(this);

        btn002 = findViewById(R.id.btn_002);
        btn002.setOnClickListener(this);

        btn003 = findViewById(R.id.btn_003);
        btn003.setOnClickListener(this);

        btn004 = findViewById(R.id.btn_004);
        btn004.setOnClickListener(this);

        btn005 = findViewById(R.id.btn_005);
        btn005.setOnClickListener(this);

        btn006 = findViewById(R.id.btn_006);
        btn006.setOnClickListener(this);

        PrintID.getInstance().startConnection();
        onNewIntent(getIntent());

        final View iconConnect = findViewById(R.id.icon_connect);
        final View iconDisconnect = findViewById(R.id.icon_disconnect);
        final TextView connectionTV = findViewById(R.id.status_connection);

        if(PrintID.getInstance().isConnected()) {
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
        PrintID.getInstance().setOnChangeConnection(new IDDeviceListeners.OnChangeConnectionListener() {
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
            PrintID.getInstance().startConnection();
    }

    @Override
    public void onClick(final View view) {

        if(PrintID.getInstance().isConnected()) {
            progressDialog = ProgressDialog.show(this, null, getString(R.string.waiting), true);

            Handler handler = new Handler(Looper.getMainLooper());
            handler.post(new Runnable() {
                @Override
                public void run() {

                    if (view.equals(btn001)) {
                        showAlert(PrintID.getInstance().ImprimirTestes());
                    }
                    else if (view.equals(btn002)) {

                        PrintID.getInstance().ImprimirCodigoQR("TESTE", 4, EnumQRCorrecaoErro.BAIXO, EnumQRModelo.MODELO_1);
                        showAlert("QR enviado para impressora");
                    }
                    else if (view.equals(btn003)) {
                        PrintID.getInstance().AtivarGuilhotina(EnumTipoCorte.PARCIAL);
                        closeLoading();
                    }
                    else if (view.equals(btn004)) {
                        PrintID.getInstance().AtivarGuilhotina(EnumTipoCorte.TOTAL);
                        closeLoading();
                    }
                    else if (view.equals(btn005)) {
                        PrintID.getInstance().ImprimirFormatado("Hello PrintId\n", false, false, true, true);
                        PrintID.getInstance().ImprimirFormatado("Default\n", false, false, false, false);
                        PrintID.getInstance().ImprimirFormatado("Expandido\n", false, false, true, false);
                        PrintID.getInstance().ImprimirFormatado("Itálico\n", true, false, false, false);
                        PrintID.getInstance().ImprimirFormatado("Sublinhado\n\n", false, true, false, false);
                        PrintID.getInstance().ImprimirFormatado("Fim.\n\n", false, false, false, true);
                        closeLoading();
                    }
                    else if (view.equals(btn006)) {
                        PrintID.getInstance().ConfigurarCodigoDeBarras(60, 80, EnumPosicaoCaracteresBarras.CARACTERES_ABAIXO);
                        PrintID.getInstance().ImprimirCodigoDeBarras("A123456789B", EnumTipoCodigoBarras.CODABAR);
                        showAlert("Código de barras enviado para impressora");
                    }
                }
            });
        }
        else {
            this.showAlert(getString(R.string.disconnected));
        }
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
}
