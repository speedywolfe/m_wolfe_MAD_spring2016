package com.example.speedywolfe.lab9_spring;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class BulbCategoryActivity extends ListActivity {

    private String bulbtype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("in on create");
        Intent i = getIntent();
        bulbtype = i.getStringExtra("bulbtype");

        ListView listBulbs = getListView();
        ArrayAdapter<Bulb> listAdapter;
        System.out.println("here");
        System.out.println(bulbtype);
        switch (bulbtype) {
            case "Tulips":
                listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_list_item_1, Bulb.tulips);
                break;
            case "Daffodils":
                listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_list_item_1, Bulb.daffodils);
                break;
            case "Iris":
                listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_list_item_1, Bulb.iris);
                break;
            default: listAdapter = new ArrayAdapter<Bulb>(this, android.R.layout.simple_list_item_1, Bulb.tulips);
        }
        listBulbs.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listview, View view, int position, long id) {
        Intent intent = new Intent(BulbCategoryActivity.this, BulbActivity.class);
        intent.putExtra("bulbid", (int) id);
        intent.putExtra("bulbtype", bulbtype);
        startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()) {
            case R.id.create_order:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
