# JDX Reverse Engineering JSON Example

Copyright © 2025 Software Tree, LLC. All rights reserved.

> **Note:** This file is written in Markdown and is best viewed with a Markdown viewer (e.g., GitHub, GitLab, VS Code, or a dedicated Markdown reader).

## Overview

This repository demonstrates the reverse-engineering capabilities of the **JDX ORM** framework, which can automatically generate Java class definitions and mapping specifications from an existing relational database schema. The generated model classes are compatible with both **JDX ORM** and **Gilhari ORM**, making them suitable for use in various deployment scenarios including standalone applications, microservices, and MCP (Model Context Protocol) servers.

The example uses the **Sakila** sample database (a MySQL reference database), demonstrating how to reverse-engineer a subset of the relational schema into a JSON object data model.

## Project Structure

```
JDX_ReverseEngineeringJSONExample/
├── config/
│   ├── mysql_sakila_example_template.config       # Template for reverse-engineering configuration
│   ├── mysql_sakila_example_template.config.revjdx # Generated reverse-engineered mapping file
│   └── JDXDemo.config                             # Configuration for JDXDemo GUI application
├── bin/                                            # Compiled class files (generated)
├── Film.java                                       # Generated model class
├── Film_Actor.java                                # Generated model class
├── Film_Category.java                             # Generated model class
├── compile.bat                                    # Batch script to compile Java sources
├── JDXDemo.bat                                    # Batch script to launch JDXDemo GUI
├── setEnvironment.bat                             # Batch script to configure environment variables
├── README.md                                      # This file
└── sources.txt                                    # List of Java source files
```

## Prerequisites

### System Requirements

- **Java Development Kit (JDK):** Version 8 or higher
- **Operating System:** Windows (for `.bat` files) or Linux/macOS (for `.sh` equivalents)
- **Database:** MySQL with the Sakila sample database installed

### Software Setup

1. **JDX ORM SDK or Gilhari SDK Installation:**
   Ensure that either the JDX ORM SDK or Gilhari SDK is installed on your system.

2. **Environment Variable (`JX_HOME`):**
   Set the `JX_HOME` environment variable to point to the top-level installation directory of your JDX ORM or Gilhari SDK:
   ```
   set JX_HOME=C:\path\to\jdx_or_gilhari_home
   ```

3. **MySQL JDBC Driver:**
   The example uses MySQL Connector/J. Update the path in `setEnvironment.bat` to match your local MySQL JDBC driver location. The current configuration references:
   ```
   c:\mysql-connector-java-5.1.39\mysql-connector-java-5.1.39-bin.jar
   ```
   Adjust this path as needed for your environment.

4. **Database Configuration:**
   Update `config/mysql_sakila_example_template.config` with your MySQL connection details:
   - `JDX_DATABASE` URL and credentials
   - `JDBC_DRIVER` path (if different from the default)

## Getting Started

### Step 1: Configure Database Connection

Edit `config/mysql_sakila_example_template.config` and update the connection string:

```ini
JDX_DATABASE JDX:jdbc:mysql://localhost:3306/sakila;USER=your_username;PASSWORD=your_password;JDX_DBTYPE=MYSQL;DEBUG_LEVEL=5
JDBC_DRIVER com.mysql.jdbc.Driver
```

### Step 2: Run Reverse Engineering Tool

Execute the reverse-engineering tool to generate classes and mapping specifications:

```bash
JDXReverseEngineer.bat
```

This command will:
- Read the template configuration file (`mysql_sakila_example_template.config`)
- Connect to your MySQL database
- Analyze the specified tables (`film`, `film_actor`, `film_category`)
- Generate Java model classes
- Create a reverse-engineered mapping file (`.revjdx`)

### Step 3: Compile Generated Classes

Compile the reverse-engineered classes using the provided batch script:

```bash
compile.bat
```

This script:
- Collects all Java source files listed in `sources.txt`
- Compiles them to the `bin/` directory
- Includes necessary JDX and external libraries in the classpath

### Step 4: Explore with JDXDemo GUI

Launch the interactive demonstration application to explore the generated classes and perform ORM operations:

```bash
JDXDemo.bat
```

The JDXDemo GUI allows you to:
- View the generated model classes
- Test database queries and operations
- Inspect relationships between entities
- Validate the mapping specifications

## Configuration Files

### Template Configuration (`mysql_sakila_example_template.config`)

This file defines the reverse-engineering parameters:

```ini
JDX_DATABASE              # Database connection string with JDBC URL
JDBC_DRIVER               # JDBC driver class name
JDX_OBJECT_MODEL_PACKAGE  # Package name for generated classes
JDX_SUPERCLASS_NAME       # Superclass for generated model classes
JDX_GENERATE_ACCESSOR_METHODS  # Whether to generate getter/setter methods
JDX_GENERATE_JSON_MAPPINGS     # Enable JSON mapping specification generation
CLASS [ClassName] TABLE [TableName]  # Specify tables to reverse-engineer
```

**Key Configuration Options:**

- `JDX_SUPERCLASS_NAME com.softwaretree.jdx.JDX_JSONObject`: Generated (container) classes inherit from `JDX_JSONObject`, making them JSON-capable
- `JDX_GENERATE_JSON_MAPPINGS TRUE`: Generates declarative mapping specifications for the container (JSON-capable) classes
- `JDX_GENERATE_ACCESSOR_METHODS FALSE`: Direct field access instead of getter/setter methods (adjust as needed)

### Generated Reverse-Engineered Mapping (`mysql_sakila_example_template.config.revjdx`)

The `.revjdx` file contains the complete mapping specification created by the reverse-engineering tool. It includes:

- **Virtual Attributes:** Mapped database columns with their Java types
- **Primary Keys:** Primary key attributes derived from table definitions
- **Relationships:** One-to-one, one-to-many relationships inferred from the schema
- **Null Handling:** SQLMAP declarations for nullable columns
- **Collection Classes:** Array or collection definitions for relationships

Example excerpt:
```
CLASS .Film TABLE film
    VIRTUAL_ATTRIB film_id ATTRIB_TYPE short
    VIRTUAL_ATTRIB title ATTRIB_TYPE java.lang.String
    VIRTUAL_ATTRIB description ATTRIB_TYPE java.lang.String
    PRIMARY_KEY film_id 
    RELATIONSHIP listFilm_Category REFERENCES .ListFilm_Category BYVALUE WITH film_id 
    SQLMAP FOR description NULLABLE
;
```

### JDXDemo Configuration (`config/JDXDemo.config`)

Specifies which reverse-engineered classes and mapping files to use in the JDXDemo application:

```ini
JDX_ORMFile  config/mysql_sakila_example_template.config.revjdx
Classes      com.softwaretree.jdxmysqlsakilaexample.reversed.json.model.Film ...
```

## Generated Model Classes (Container Domain Model)

When `JDX_GENERATE_JSON_MAPPINGS` is set to `TRUE`, the reverse-engineering process produces simple shell (container) classes corresponding to the domain-specific JSON object model classes of related entities based on the configured database tables.

### Container Domain Model Architecture

**JDX_JSONObject Base Class:**
The generated container classes inherit from `JDX_JSONObject`, which serves as the foundational base class for handling persistence of domain-specific JSON objects. This superclass provides comprehensive ORM functionality, so the container classes remain lean and focused.

**Container Domain Model Classes:**
The generated container classes (e.g., `Film.java`, `Film_Category.java`, `Film_Actor.java`) are minimal shell classes that:
- Define only two constructors (typically a no-arg constructor and a parameterized constructor)
- Delegate all persistence, serialization, and ORM processing to the `JDX_JSONObject` superclass
- Maintain a clean separation between schema definition (in the `.revjdx` mapping file) and container implementation

**Domain-Specific JSON Objects:**
JDX and Gilhari do not require explicit programmatic definitions (e.g., ES6-style JavaScript classes) for the domain-specific JSON object model classes themselves. Instead, the framework handles all JSON object data using instances of these container domain model classes in conjunction with the declarative ORM specification (`.revjdx` file). This approach enables:
- Schema-driven domain model management
- Consistent handling of complex nested JSON structures
- Seamless mapping between relational and JSON representations

### Generated Classes

#### Film.java
Container class representing the `film` table, providing a wrapper for JSON objects containing film information (title, description, release year, rental rate, etc.) and relationships to film categories. The actual data structure and persistence behavior is defined in the mapping specification.

#### Film_Category.java
Container class representing the `film_category` table, serving as a junction entity linking films to categories within the JSON domain model.

#### Film_Actor.java
Container class representing the `film_actor` table, serving as a junction entity linking films to actors within the JSON domain model.

### Typical Container Class Structure

A generated container class typically looks like:

```java
public class FilmActor extends JDX_JSONObject {
    
    // No-argument constructor
    public FilmActor() {
        super();
    }
    
    // Parameterized constructor
    public FilmActor(String initialJsonData) {
        super(initialJsonData);
    }
}
```

The container class is intentionally minimal because all attribute mapping, relationship handling, JSON serialization, persistence logic, and ORM operations are managed by the `JDX_JSONObject` superclass based on the declarative mapping specification.

## Post-Generation Customization

After reverse engineering, you can enhance the generated classes and mappings:

### Modifying Generated Classes

- Add custom business logic or methods to the generated classes
- Override default behavior while preserving ORM functionality
- Add validation logic or computed properties
- Implement additional interfaces as needed

### Adjusting Mapping Specifications

- Remove unnecessary attributes or relationships
- Modify attribute types or null handling
- Adjust collection types or relationship cardinality
- Add custom fetch strategies or lazy loading hints

**Important:** When modifying the mapping file, preserve the `.revjdx` extension and maintain proper syntax. Refer to the JDX User Manual for detailed mapping specification documentation.

## Usage Scenarios

### Standalone Applications

Use the generated classes with JDX ORM for traditional desktop or server applications.

### Microservices (Gilhari)

Deploy the same model classes with Gilhari ORM for microservice architectures, benefiting from containerized deployments and service-oriented design.

### MCP Servers

Integrate the generated classes into MCP (Model Context Protocol) servers through Gilhari for standardized model serving and composition scenarios.

## Troubleshooting

### Connection Issues

- Verify MySQL is running and accessible at the specified host and port
- Check database credentials in the template configuration
- Ensure the MySQL JDBC driver JAR is in the classpath

### Compilation Errors

- Verify `JX_HOME` is set correctly
- Check that all required JAR files are present in the classpath
- Ensure `sources.txt` lists the correct source file paths

### Class Loading Issues

- Verify the package name in `JDX_OBJECT_MODEL_PACKAGE` matches the generated classes
- Ensure compiled classes are in the `bin/` directory
- Check that `config/` directory is in the classpath

### Relationship Mapping Issues

- Verify foreign key constraints exist in the database schema
- Check that table names in the configuration match database table names exactly
- Review the generated `.revjdx` file for correct RELATIONSHIP definitions

## Platform-Specific Considerations

### Windows

Use the provided `.bat` scripts directly from the command prompt or PowerShell.

### Linux/macOS

Equivalent `.sh` scripts should be created with the same logic:
- Use `#!/bin/bash` shebang
- Use `:` instead of `;` for PATH separators
- Adjust paths for Unix-style directory structures

Example `setEnvironment.sh`:
```bash
export CLASSPATH=.:./bin:./config:$JX_HOME/config:$JX_HOME/libs/jxclasses.jar:$JX_HOME/libs/jdxtools.jar:$JX_HOME/external_libs/json-20240303.jar:/path/to/mysql-connector-java-5.1.39-bin.jar
```

## Advanced Topics

### Customizing Package Names

Modify `JDX_OBJECT_MODEL_PACKAGE` in the template configuration to organize generated classes in your preferred package structure.

### Using Different Superclasses

Change `JDX_SUPERCLASS_NAME` to use a custom base class, though ensure it's compatible with JDX ORM requirements.

### Reverse-Engineering Additional Tables

Add more `CLASS ... TABLE ...` declarations to the template configuration to reverse-engineer additional database tables.

### Incremental Updates

Run the reverse-engineering tool again after schema changes. The `.revjdx` file will be regenerated with updated mappings.

## References

For comprehensive information, refer to the following resources:

- **JDX User Manual:** Consult the "Reverse Engineering" section for detailed documentation
- **Sakila Database:** MySQL provides comprehensive documentation on the Sakila sample database
- **JDX Configuration Reference:** Detailed explanation of all configuration options in the official documentation
- **Gilhari ORM Documentation:** Guidance on deploying generated classes with Gilhari ORM

## Support and Contribution

For questions, issues, or suggestions:

- Consult the official JDX and Gilhari documentation
- Review the configuration examples in this repository
- Contact the development team or community support

## License and Attribution

This example is provided as part of the JDX ORM and Gilhari frameworks. Refer to the JDX/Gilhari licensing terms for usage restrictions and requirements.

The Sakila sample database is provided by MySQL and is available under the New BSD License.

---

**Last Updated:** August 2025  
**JDX Version:** 05.05 (as indicated in reverse-engineered files)