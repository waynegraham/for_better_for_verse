package edu.virginia.prosody;

import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.xpath.XPathExpressionException;

import net.sf.saxon.Configuration;
import net.sf.saxon.om.NamespaceConstant;
import net.sf.saxon.pull.NamespaceContextImpl;
import net.sf.saxon.sxpath.IndependentContext;
import net.sf.saxon.xpath.XPathEvaluator;
import org.xml.sax.InputSource;

/**
 * @author ajs6f
 * 
 */
public class Check extends HttpServlet implements Servlet {

	static final long serialVersionUID = 1;

	private String POEMS_DIRECTORY = "poems/";
	private final String CORRECT_RESPONSE = "correct.xml";
	private final String INCORRECT_RESPONSE = "incorrect.xml";
	private ServletContext context = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		if (config.getServletContext().getInitParameter("POEMS_DIRECTORY") != null) {
			this.POEMS_DIRECTORY = config.getServletContext().getInitParameter(
					"POEMS_DIRECTORY");
		}
		if (config.getServletContext().getInitParameter("CORRECT_RESPONSE") != null) {
			this.POEMS_DIRECTORY = config.getServletContext().getInitParameter(
					"CORRECT_RESPONSE");
		}
		if (config.getServletContext().getInitParameter("INCORRECT_RESPONSE") != null) {
			this.POEMS_DIRECTORY = config.getServletContext().getInitParameter(
					"INCORRECT_RESPONSE");
		}
		context = getServletContext();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String answer = req.getParameter("answer");
		String poem = req.getParameter("poem");
		String filepath = context.getRealPath(POEMS_DIRECTORY + poem);

		Integer line = Integer.parseInt(req.getParameter("line"));
		String xpath = "string-join(//TEI:l[@n='" + line + "']/TEI:seg/@met,'')";
		log("Using xpath " + xpath);
		
		try {

			log("Reading " + filepath);
			System.setProperty("javax.xml.xpath.XPathFactory:"
					+ NamespaceConstant.OBJECT_MODEL_SAXON,
					"net.sf.saxon.xpath.XPathFactoryImpl");
			IndependentContext xpathcontext = new IndependentContext(new Configuration());
			xpathcontext.declareNamespace("TEI","http://www.tei-c.org/ns/1.0");
			XPathEvaluator xp = new XPathEvaluator();
			xp.setNamespaceContext(new NamespaceContextImpl(xpathcontext.getNamespaceResolver()));
			String realanswer = xp.evaluate(xpath,
					new InputSource(new FileInputStream(filepath)));

			if (answer.equals( realanswer) ){
				log("The proffered answer was: " + answer + ", and the correct answer was indeed " + realanswer);
				resp.sendRedirect(CORRECT_RESPONSE);
			} else {
				log("The proffered answer was: " + answer + ", whereas the correct answer was " + realanswer);
				resp.sendRedirect(INCORRECT_RESPONSE);
			}
		} catch (XPathExpressionException e) {
			log(e.toString(),e);
			e.printStackTrace();
		}

	}

}
