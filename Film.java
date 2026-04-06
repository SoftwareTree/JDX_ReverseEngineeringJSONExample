// 
// JDX (version: 05.08) reverse engineered class
// JDX is a product of Software Tree, LLC.
// 
// DBURL=jdbc:mysql://localhost:3306/sakila, Database=MySQL, Version: 8.0.45
// Date: Sun Apr 05 21:54:09 PDT 2026
// 
package com.softwaretree.jdxmysqlsakilaexample.reversed.json.model;

import org.json.JSONException;
import org.json.JSONObject;

import com.softwaretree.jdx.JDX_JSONObject;

public class Film extends JDX_JSONObject {
    public  Film_Actor[]  listFilm_Actor;
    public  Film_Category[]  listFilm_Category;

    public Film() {
        super();
    }

    public Film(JSONObject jsonObject) throws JSONException {
        super(jsonObject);
    }
}
