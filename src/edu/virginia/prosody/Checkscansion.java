package edu.virginia.prosody;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Arrays;
import java.util.regex.Pattern;

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
public class Checkscansion extends HttpServlet implements Servlet {

	static final long serialVersionUID = 1;

	private String POEMS_DIRECTORY = "poems/";
	private static String CORRECT_RESPONSE = "correct.xml";
	private static String INCORRECT_RESPONSE = "incorrect.xml";
	private static String EXPECTED_RESPONSE = "expected.xml";
	private ServletContext context = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		if (config.getServletContext().getInitParameter("POEMS_DIRECTORY") != null) {
			this.POEMS_DIRECTORY = config.getServletContext().getInitParameter(
					"POEMS_DIRECTORY");
		}
		if (config.getServletContext().getInitParameter("CORRECT_RESPONSE") != null) {
			Checkscansion.CORRECT_RESPONSE = config.getServletContext()
					.getInitParameter("CORRECT_RESPONSE");
		}
		if (config.getServletContext().getInitParameter("INCORRECT_RESPONSE") != null) {
			Checkscansion.INCORRECT_RESPONSE = config.getServletContext()
					.getInitParameter("INCORRECT_RESPONSE");

		}
		if (config.getServletContext().getInitParameter("EXPECTED_RESPONSE") != null) {
			Checkscansion.EXPECTED_RESPONSE = config.getServletContext()
					.getInitParameter("EXPECTED_RESPONSE");
		}
		context = getServletContext();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String answer = req.getParameter("answer");
		String poem = req.getParameter("poem");
		String filepath = context.getRealPath(POEMS_DIRECTORY + poem);
		Boolean correct = false;
		Boolean expected = false;

		Integer line = Integer.parseInt(req.getParameter("line"));
		String xpathexpected = "//TEI:l[@n='" + line + "']/@met";
		String xpathcorrect = "//TEI:l[@n='" + line + "']/@real";
		log("Using xpaths " + xpathexpected + " and " + xpathcorrect);

		log("Reading " + filepath);
		log("The proffered answer was: " + answer);
		System.setProperty("javax.xml.xpath.XPathFactory:"
				+ NamespaceConstant.OBJECT_MODEL_SAXON,
				"net.sf.saxon.xpath.XPathFactoryImpl");
		IndependentContext xpathcontext = new IndependentContext(
				new Configuration());
		xpathcontext.declareNamespace("TEI", "http://www.tei-c.org/ns/1.0");
		XPathEvaluator xp = new XPathEvaluator();

		xp.setNamespaceContext(new NamespaceContextImpl(xpathcontext
				.getNamespaceResolver()));

		try {

			List<String> realanswers = Arrays.asList(xp.evaluate(xpathcorrect,
					new InputSource(new FileInputStream(filepath))).split("[|]"));
			List<String> quotedrealanswers = quote(realanswers);
			String realanswer = join(quotedrealanswers, "|");
			log("The correct answers were: " + realanswer);
			if (answer.matches(realanswer)) {
				correct = true;
			} else {
				List<String> expectedanswers = Arrays.asList(xp.evaluate(
						xpathexpected,
						new InputSource(new FileInputStream(filepath))).split(
						"[|]"));
				List<String> quotedexpectedanswers = quote(expectedanswers);
				String expectedanswer = join(quotedexpectedanswers, "|");
				log("The expect-able answers were " + expectedanswer);
				if (answer.matches(expectedanswer)) {
					expected = true;
				}
			}
		} catch (XPathExpressionException e) {
			// TODO Auto-generated catch block
			log(e.toString(), e);
			e.printStackTrace();
		}

		if (correct) {
			resp.sendRedirect(CORRECT_RESPONSE);
		} else if (expected) {
			resp.sendRedirect(EXPECTED_RESPONSE);
		} else {
			resp.sendRedirect(INCORRECT_RESPONSE);
		}
	}

	public static String join(List<String> s, String delimiter) {
		StringBuffer buffer = new StringBuffer();
		Iterator<String> iter = s.iterator();
		while (iter.hasNext()) {
			buffer.append(iter.next());
			if (iter.hasNext()) {
				buffer.append(delimiter);
			}
		}
		return buffer.toString();
	}

	public static List<String> quote(List<String> col) {
		List<String> quotedlist = new ArrayList<String>(0);
		for (String i : col) {
			quotedlist.add(Pattern.quote(i));
		}
		return quotedlist;
	}

}
