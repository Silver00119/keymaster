package hf.keymaster.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import hf.keymaster.application.Application;
import hf.keymaster.application.ApplicationDAO;
import hf.keymaster.license.License;
import hf.keymaster.license.LicenseDAO;
import hf.keymaster.license.owned.OwnedLicense;
import hf.keymaster.license.owned.OwnedLicenseDAO;
import hf.keymaster.user.UserDAO;

@WebServlet(name = "AuthenticateServelt", displayName = "AuthenticateServelt", urlPatterns = {
		"/api/v1/authenticate/*" })
public class AuthenticateServelt extends HttpServlet {
	private static final long serialVersionUID = 4730368368886662526L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getPathInfo();
		String[] paths = path.split("/");
		String ApiKey = paths[1];

		response.setContentType("application/json");

		if (!(ApiKey == null || ApiKey.length() != 32)) {
			String Username = request.getParameter("username");
			String Password = request.getParameter("password");
			PrintWriter out = response.getWriter();

			if (!(Username != null && Password != null)) {
				int UserID = UserDAO.loginUser(Username, Password);

				if (UserID != -1) {
					Application _a = ApplicationDAO.getApplication(ApiKey);
					List<OwnedLicense> _ow = OwnedLicenseDAO.getOwnedLicenses(UserDAO.getUser(UserID));
					List<License> _lic = LicenseDAO.getLicenses(_a);
					if (_a != null && _ow != null && _lic != null) {
						for (OwnedLicense ow : _ow) {
							for (License lic : _lic) {
								if (ow.getLicenseID() == lic.getID()) {
									if (OwnedLicenseDAO.isActive(ow)) {
										ApiResponse apiResponse = new ApiResponse(_a.getName(), lic.getName(),
												lic.getDescription(), lic.getType(), ow.getActivationEpoch());
										ObjectMapper mapper = new ObjectMapper();
										String Json = mapper.writeValueAsString(apiResponse);
										out.print(Json);
										out.flush();
									} else {
										/* License exsist but expired */ }
								}
							}
						}
					} else {
						/* No license */ }
				} else {
					/* Wrong Username or Password */ }
			} else {
				/* No username or password */ }
		} else {
			/* Bad Api */ }
	}
}