package com.example.speedywolfe.m_wolfe_final;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class WorkoutActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_workout);

        int workoutnum = (Integer)getIntent().getExtras().get("workoutid");
        String type = (String)getIntent().getExtras().get("workouttype");

        Workout workout;
        switch (type) {
            case "Cardio":
                workout = Workout.Cardio[workoutnum];
                break;
            case "Strength":
                workout = Workout.Strength[workoutnum];
                break;
            case "Flexibility":
                workout = Workout.Flexibility[workoutnum];
                break;
            default:
                workout = Workout.Cardio[workoutnum];
        }

        ImageView workoutImage = (ImageView)findViewById(R.id.workoutImageView);
        workoutImage.setImageResource(workout.getImageResourceID());

        TextView workoutname = (TextView)findViewById(R.id.workout_name);
        workoutname.setText(workout.getName());
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
