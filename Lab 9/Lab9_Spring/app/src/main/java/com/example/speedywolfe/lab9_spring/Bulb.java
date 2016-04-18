package com.example.speedywolfe.lab9_spring;

/**
 * Created by speedywolfe on 4/17/16.
 */
public class Bulb {
    private String name;
    private int imageResourceID;

    private Bulb(String newname, int newID) {
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Bulb[] tulips = {
            new Bulb("Daydream", R.drawable.daydream),
            new Bulb("Apeldoorn Elite", R.drawable.apeldoorn),
            new Bulb("Banja Luka", R.drawable.banjaluka),
            new Bulb("Burning Heart", R.drawable.burningheart),
            new Bulb("Cape Cod", R.drawable.capecod)
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
