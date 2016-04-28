package com.example.speedywolfe.m_wolfe_final;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class WorkoutCategoryActivity extends ListActivity {

    private String worktype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent i = getIntent();
        worktype = i.getStringExtra("worktype");

        ListView listBulbs = getListView();
        ArrayAdapter<Workout> listAdapter;
        System.out.println("here");
        System.out.println(worktype);
        switch (worktype) {
            case "Cardio":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.Cardio);
                break;
            case "Strength":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.Strength);
                break;
            case "Flexibility":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.Flexibility);
                break;
            default: listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.Cardio);
        }
        listBulbs.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listview, View view, int position, long id) {
        Intent intent = new Intent(WorkoutCategoryActivity.this, WorkoutActivity.class);
        intent.putExtra("workoutid", (int) id);
        intent.putExtra("workouttype", worktype);
        startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()) {
            case R.id.sign_up:
                Intent intent = new Intent(this, SignActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
