import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout") //como le llamamos (URL Servlet)
public class LogoutServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  //Se usa doGet para obtener una página. Un post para enviar un formulario por ejemplo
        HttpSession currentSession = request.getSession(); //obtenemos la sesión actual
        currentSession.invalidate(); //invalidamos la sesión = cerrarla
        response.sendRedirect("/wikibook"); //nos redirige a la URL steam al cerrar la sesión
    }
}
