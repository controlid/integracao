package br.com.controlid.satidtest;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.hardware.usb.UsbManager;
import android.nfc.Tag;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.Random;

import br.com.controlid.satid.SATiD;
import br.com.controlid.satid.communication.ISATiDListeners;
import br.com.controlid.satid.enums.EnumOptionCode;
import br.com.controlid.satid.enums.EnumSatStatus;
import br.com.controlid.satid.enums.EnumStateCode;
import br.com.controlid.satid.enums.EnumSubCommand;


/**
 * MainActivityIndividualListeners
 *
 * @author Elian Medeiros
 * @version 1.0.0
 * @since Release 08/18
 */
public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    // Controller
    private String activateCode = "senha12345";
    private String cnpjSH = "16716114000172";
    private String cnpjCont = "08238299000129";
    private String signatureAC = "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT";

    private ProgressDialog progressDialog;
    private Button btnActivate;
    private Button btnIcpCertificate;
    private Button btnConsultSat;
    private Button btnSendSalesData;
    private Button btnCancelLastSale;
    private Button btnTestEndOfEnd;
    private Button btnConsultOperationalStatus;
    private Button btnConsultSessionId;
    private Button btnAssociateSignature;
    private Button btnNetworkInterface;
    private Button btnUpdateSoftware;
    private Button btnLogs;
    private Button btnBlock;
    private Button btnUnlock;
    private Button btnChangeActivateCode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        try { getSupportActionBar().hide(); } catch(Exception e) { /**/ } // Remove action bar

        setContentView(R.layout.activity_main);

        SATiD.config(getApplicationContext());

        btnActivate = findViewById(R.id.btn_activate);
        btnActivate.setOnClickListener(this);

        btnIcpCertificate = findViewById(R.id.btn_icp_certificate);
        btnIcpCertificate.setOnClickListener(this);

        btnConsultSat = findViewById(R.id.btn_consult);
        btnConsultSat.setOnClickListener(this);

        btnSendSalesData = findViewById(R.id.btn_send_sales);
        btnSendSalesData.setOnClickListener(this);

        btnCancelLastSale = findViewById(R.id.btn_cancel_last_sale);
        btnCancelLastSale.setOnClickListener(this);

        btnTestEndOfEnd = findViewById(R.id.btn_test_end_of_end);
        btnTestEndOfEnd.setOnClickListener(this);

        btnConsultOperationalStatus = findViewById(R.id.btn_consult_operational_status);
        btnConsultOperationalStatus.setOnClickListener(this);

        btnConsultSessionId = findViewById(R.id.btn_consult_session);
        btnConsultSessionId.setOnClickListener(this);

        btnAssociateSignature = findViewById(R.id.btn_associate_signature);
        btnAssociateSignature.setOnClickListener(this);

        btnUpdateSoftware = findViewById(R.id.btn_update_software);
        btnUpdateSoftware.setOnClickListener(this);

        btnNetworkInterface = findViewById(R.id.btn_config_network);
        btnNetworkInterface.setOnClickListener(this);

        btnLogs = findViewById(R.id.btn_logs);
        btnLogs.setOnClickListener(this);

        btnBlock = findViewById(R.id.btn_block);
        btnBlock.setOnClickListener(this);

        btnUnlock = findViewById(R.id.btn_unlock);
        btnUnlock.setOnClickListener(this);

        btnChangeActivateCode = findViewById(R.id.btn_change_code);
        btnChangeActivateCode.setOnClickListener(this);

        SATiD.getInstance().startConnection();
        onNewIntent(getIntent());

        final TextView connectionTV = findViewById(R.id.status_connection);
        connectionTV.setText(SATiD.getInstance().isConnected() ? EnumSatStatus.CONNECTED.toString() : EnumSatStatus.DISCONNECTED.toString());

        // Example listener inline OnChangeConnection USB
        SATiD.getInstance().setOnChangeConnection(new ISATiDListeners.OnChangeConnectionListener() {
            @Override
            public void status(EnumSatStatus enumSatStatus) {
                connectionTV.setText(enumSatStatus.toString());
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
            SATiD.getInstance().startConnection();
    }

    @Override
    public void onClick(final View view) {

        if(SATiD.getInstance().isConnected()) {
            progressDialog = ProgressDialog.show(this, null, getString(R.string.waiting), true);

            Handler handler = new Handler(Looper.getMainLooper());
            handler.post(new Runnable() {
                @Override
                public void run() {
                    int session = new Random().nextInt(1001);

                    if (view.equals(btnActivate))
                        showAlert(SATiD.getInstance().AtivarSAT(session, EnumSubCommand.CERT_AC_SAT, activateCode, cnpjCont, EnumStateCode.SAO_PAULO));

                    else if (view.equals(btnIcpCertificate))
                        showAlert(SATiD.getInstance().ComunicarCertificadoICPBRASIL(session, activateCode, "ASDASD"));

                    else if (view.equals(btnConsultSat))
                        showAlert(SATiD.getInstance().ConsultarSAT(session));

                    else if (view.equals(btnSendSalesData))
                        showAlert(SATiD.getInstance().EnviarDadosVenda(4, activateCode, ""));

                    else if (view.equals(btnCancelLastSale))
                        showAlert(SATiD.getInstance().CancelarUltimaVenda(session, activateCode, "", ""));

                    else if (view.equals(btnTestEndOfEnd))
                        showAlert(SATiD.getInstance().TesteFimAFim(session, activateCode, ""));

                    else if (view.equals(btnConsultOperationalStatus))
                        showAlert(SATiD.getInstance().ConsultarStatusOperacional(session, activateCode));

                    else if (view.equals(btnConsultSessionId))
                        showAlert(SATiD.getInstance().ConsultarNumeroSessao(session, activateCode, 3));

                    else if (view.equals(btnAssociateSignature))
                        showAlert(SATiD.getInstance().AssociarAssinatura(session, activateCode, cnpjSH + cnpjCont, signatureAC));

                    else if (view.equals(btnNetworkInterface))
                        showAlert(SATiD.getInstance().ConfigurarInterfaceDeRede(session, activateCode, ""));

                    else if (view.equals(btnUpdateSoftware))
                        showAlert(SATiD.getInstance().AtualizarSoftwareSAT(session, activateCode));

                    else if (view.equals(btnLogs))
                        showAlert(SATiD.getInstance().ExtrairLogs(session, activateCode));

                    else if (view.equals(btnBlock))
                        showAlert(SATiD.getInstance().BloquearSAT(session, activateCode));

                    else if (view.equals(btnUnlock))
                        showAlert(SATiD.getInstance().DesbloquearSAT(session, activateCode));

                    else if (view.equals(btnChangeActivateCode))
                        showAlert(SATiD.getInstance().TrocarCodigoDeAtivacao(session, activateCode, EnumOptionCode.ACTIVATION_CODE, "senha123", "senha123"));
                }
            });
        }
        else {
            this.showAlert(getString(R.string.sat_disconnected));
        }
    }

    public void showAlert(String message) {
        if(progressDialog != null)
            progressDialog.dismiss();

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
