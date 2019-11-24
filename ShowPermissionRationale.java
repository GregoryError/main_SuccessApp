// Java code to request data read/write permissions
package org.bytran.bytran;

import android.Manifest;
import java.lang.Runnable;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;

// Method to request permissions for the read and write from / to an external storage
public class ShowPermissionRationale
{
        // Activity variable passed in from the Qt program
    private final Activity m_MainActivity;

    // Method to request permissions
    public ShowPermissionRationale(Activity MainActivity)
    {
                m_MainActivity = MainActivity;

        MainActivity.runOnUiThread(new Runnable()
        {
            @Override
            public void run()
            {
                 AlertDialog.Builder builder = new AlertDialog.Builder(m_MainActivity);
                                 builder.setMessage("Without the external storage read / write permission all data used by the application will be stored in folders inaccessible to the user. This includes the configuration file, the downloaded HITRAN database data, and the image/data files with the calculation results. The operation of bytran is otherwise the same as if the permission was granted.\n\nIf access to the above files is desired, this permission may be granted the next time bytran is launched.  Once the permission is granted the configuration file and the downloaded HITRAN data will be stored in the \"Downloads/bytran\" folder, and the calculation results will be saved to the \"Documents/bytran\" folder.")
                                                                           .setTitle("Permission denied");

                                 builder.setNegativeButton("OK", new DialogInterface.OnClickListener() {
                                 public void onClick(DialogInterface dialog, int id)
                                 { ; }
                                 });

                                 AlertDialog dialog = builder.create();
                                 dialog.show();
            }
        });
    }
}
