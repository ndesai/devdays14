package com.iktwo.qtdevdays14;

import android.content.Context;
import android.content.Intent;
import android.os.Environment;
import android.net.Uri;
import android.util.Log;
import android.widget.Toast;

import com.iktwo.qtdevdays14.R;

public class DevDays extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static final String TAG = "DevDays";
    private static DevDays m_instance;

    public DevDays()
    {
        m_instance = this;
    }

    @Override
    protected void onStart()
    {
        super.onStart();
        m_instance = this;
    }

    public static void toast(final String message)
    {
        m_instance.runOnUiThread(new Runnable() {
            public void run() {
                Toast.makeText(m_instance.getApplicationContext(), message, Toast.LENGTH_SHORT).show();
            }
        });
    }

    public static boolean isTablet()
    {
        return m_instance.getResources().getBoolean(R.bool.isTablet);
    }
}
