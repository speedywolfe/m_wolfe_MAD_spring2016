package com.example.speedywolfe.lab9_spring;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class BulbCategoryActivity extends ListActivity {

    private String bulbtype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent i = getIntent();
        String bulbtype = i.getStringExtra("bulbtype");

        ListView listBulbs = getListView();
        ArrayAdapter<Bulb> listAdapter;
        switch(bulbtype) {
            case "Tulips":
                listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_list_item_1, Bulb.tulips);
                break;
            default:
            listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_expandable_list_item_1, Bulb.tulips);
        }
        listBulbs.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        Intent intent new Intent(BulbCategoryActivity.this, BulbActivity.class);
        intent.putExtra("bulbid", (int) id);
        intent.putExtra("bulbtype", bulbtype);
        startActivity(intent);
    }
}
