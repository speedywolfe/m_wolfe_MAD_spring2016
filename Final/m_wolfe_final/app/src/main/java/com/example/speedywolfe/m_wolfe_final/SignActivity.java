package com.example.speedywolfe.m_wolfe_final;

import android.app.ActionBar;
import android.os.Bundle;
import android.app.Activity;

public class SignActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign);
        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }

}
