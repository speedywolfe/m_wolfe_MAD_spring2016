package com.example.speedywolfe.lab9_spring;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class BulbMainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bulb_main);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void  onItemClick(AdapterView<?>listView, View view, int position, long id) {
                String bulbtype = (String)listView.getItemAtPosition(position);

                Intent intent = new Intent(BulbMainActivity.this, BulbCategoryActivity.class);

                intent.putExtra("bulbtype", bulbtype);
                startActivity(intent);
            }
        };
        ListView listview = (ListView)findViewById(R.id.listView);
        listview.setOnItemClickListener(itemClickListener);
    }
}
