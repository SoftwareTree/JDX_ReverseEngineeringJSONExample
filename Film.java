// 
// JDX (version: 05.05) reverse engineered class
// JDX is a product of Software Tree, LLC.
// 
// DBURL=jdbc:mysql://localhost:3306/sakila, Database=MySQL, Version: 5.7.15-log
// Date: Fri Oct 17 22:44:00 PDT 2025
// 
package com.softwaretree.jdxmysqlsakilaexample.reversed.json.model;

import org.json.JSONException;
import org.json.JSONObject;

import com.softwaretree.jdx.JDX_JSONObject;

public class Film extends JDX_JSONObject {
    public  Film_Category[]  listFilm_Category;

    public Film() {
        super();
    }

    public Film(JSONObject jsonObject) throws JSONException {
        super(jsonObject);
    }
}
