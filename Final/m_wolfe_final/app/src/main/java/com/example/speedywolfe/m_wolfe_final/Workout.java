package com.example.speedywolfe.m_wolfe_final;

/**
 * Created by speedywolfe on 4/28/16.
 */
public class Workout {
    private String name;
    private int imageResourceID;

    private Workout(String newname, int newID) {
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Workout[] Cardio = {
            new Workout("Cycling", R.drawable.cardio),
            new Workout("Running", R.drawable.cardio),
    };

    public static final Workout[] Strength = {
            new Workout("Lifting", R.drawable.strength),
            new Workout("Squats", R.drawable.strength),
    };

    public static final Workout[] Flexibility = {
            new Workout("Toe touches", R.drawable.flexibility),
            new Workout("Hamstring Stretch", R.drawable.flexibility),
    };

    public String getName() {
        return name;
    }

    public int getImageResourceID() {
        return imageResourceID;
    }

    public String toString() {
        return this.name;
    }
}
