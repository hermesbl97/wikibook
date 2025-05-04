package com.svalero.basededatos.dao;

import com.svalero.basededatos.exception.LibroNotFoundException;
import com.svalero.basededatos.model.Libro;

import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LibrosDAO {

    private Connection connection;
    public LibrosDAO(Connection connection) { //como no tenemos el valor connection porque está en otra clase. Lo pedimos creamos un constructor
        this.connection = connection;
    }

    public boolean add(Libro libro) throws SQLException {
        String sql = "INSERT INTO libros (titulo, autor, fecha_publicacion, imagen, precio, genero, editorial)" +
                " VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, libro.getTitulo());
        statement.setString(2, libro.getAutor());
        statement.setDate(3, libro.getFecha_publicacion());
        statement.setString(4, libro.getImagen());
        statement.setFloat(5, libro.getPrecio());
        statement.setString(6, libro.getGenero());
        statement.setString(7, libro.getEditorial());

        int affectedRows = statement.executeUpdate(); // al convertirlo en un numero, buscamos que nos devuelva el numero de filas afectadas al borrar por ejemplo

        return affectedRows != 0;
    }

    public ArrayList<Libro> getAll() throws SQLException { //Nos devuelve una lista de juegos
        String sql = "SELECT * FROM libros"; //La consulta que queremos lanzar

        return launchQuery(sql);
    }

    public ArrayList<Libro> getAll(String search) throws SQLException {
        if (search==null || search.isEmpty()) {
            return getAll();
        }

        String sql = "SELECT * FROM libros WHERE titulo LIKE ? OR autor LIKE ?";
        return launchQuery(sql, search);
    }

    private ArrayList<Libro> launchQuery(String query, String ...search) throws SQLException { //Con los puntos suspensivos le decimos que al pasar el métdo acepte un parámetro o más. El query es obligatorio pero luego le podemos pasar tantos parámetro como queramos
        PreparedStatement statement = null;
        ResultSet result= null;

        statement = connection.prepareStatement(query);
        if (search.length > 0) {
            statement.setString(1, "%"+search[0]+"%"); //con esto hacemos la búsqueda parcial por palabra
            statement.setString(2, "%"+search[0]+"%"); //con esto hacemos la búsqueda parcial por palabra, pero tanto por nombre como por descripción tal y como dice la sentencia
        }

        result = statement.executeQuery();
        ArrayList<Libro> libroList = new ArrayList<>();
        while (result.next()){
            Libro libro = new Libro();
            libro.setId_libro(result.getInt("id_libro"));
            libro.setTitulo(result.getString("titulo"));
            libro.setAutor(result.getString("autor"));
            libro.setFecha_publicacion(result.getDate("fecha_publicacion"));
            libro.setPrecio(result.getFloat("precio"));
            libro.setGenero(result.getString("genero"));
            libro.setEditorial(result.getString("editorial"));
            libro.setImagen(result.getString("imagen"));
            libroList.add(libro);
        }

        statement.close();

        return libroList;
    }

    public Libro get(int id_libro) throws SQLException, LibroNotFoundException { //Nos devuelve un juego específico
        String sql = "SELECT * FROM libros WHERE  id_libro = ?"; //Con el interrogante le pasamos el ID
        PreparedStatement statement = null; //Objteo java que va a lanzar la consulta contra la base de datos
        ResultSet result= null; //objeto que almacena el resultado de la consulta

        statement = connection.prepareStatement(sql); //creamos statement con el código sql
        statement.setInt(1,id_libro); //Aquí le decimos que el primer interrogante que le pasamos es el id que le hemos pasado en el método
        result = statement.executeQuery(); //lanza la consulta

        if(!result.next()) { //Si no avanza ninguna casilla no devuelve nada
            throw new LibroNotFoundException(); //
        }

        Libro libro = new Libro();
        libro.setId_libro(result.getInt("id_libro"));
        libro.setTitulo(result.getString("titulo"));
        libro.setAutor(result.getString("autor"));
        libro.setImagen(result.getString("imagen"));
        libro.setFecha_publicacion(result.getDate("fecha_publicacion"));
        libro.setPrecio(result.getFloat("precio"));
        libro.setGenero(result.getString("genero"));
        libro.setEditorial(result.getString("editorial"));

        statement.close(); //cerramos la sentencia para liberar memoria. Y desconectamos.

        return libro;
    }

    public ArrayList<Libro> search(String searchTerm) { //nos hará una búsqueda en función a un término que le pasemos
        //TODO
        return null;
    }

    public boolean modify (Libro libro) throws SQLException { //nos modificará un juego cuando le pasemos un id
        String sql = "UPDATE libros SET titulo = ?, autor = ?, precio = ?, " +
                "fecha_publicacion = ?, genero = ?, editorial = ? WHERE id_libro = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, libro.getTitulo());
        statement.setString(2, libro.getAutor());
        statement.setFloat(3, libro.getPrecio());
        statement.setDate(4, libro.getFecha_publicacion());
        statement.setString(5, libro.getGenero());
        statement.setString(7, libro.getEditorial());
        statement.setInt(9, libro.getId_libro());
        int affectedRows = statement.executeUpdate();
        return affectedRows != 0;
    }
    public boolean delete (int libroId) throws SQLException { //en vez de pasarle sólo el id se podría hacer pasando el juego entero
        String sql = "DELETE FROM libros WHERE id_libro = ? ";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, libroId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }

}
