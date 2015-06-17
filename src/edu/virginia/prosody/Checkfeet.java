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
import net.sf.saxon.pull.NamespaceContextImpl;
import net.sf.saxon.sxpath.IndependentContext;
import net.sf.saxon.xpath.XPathEvaluator;
import org.xml.sax.InputSource;

public class Checkfeet
  extends HttpServlet
  implements Servlet
{
  static final long serialVersionUID = 1L;
  private String POEMS_DIRECTORY = "poems/";
  private static String CORRECT_RESPONSE = "correct.xml";
  private static String INCORRECT_RESPONSE = "incorrect.xml";
  private ServletContext context = null;
  
  public void init(ServletConfig config)
    throws ServletException
  {
    super.init(config);
    if (config.getServletContext().getInitParameter("POEMS_DIRECTORY") != null) {
      this.POEMS_DIRECTORY = config.getServletContext()
        .getInitParameter("POEMS_DIRECTORY");
    }
    if (config.getServletContext().getInitParameter("CORRECT_RESPONSE") != null) {
      CORRECT_RESPONSE = 
        config.getServletContext().getInitParameter("CORRECT_RESPONSE");
    }
    if (config.getServletContext().getInitParameter("INCORRECT_RESPONSE") != null) {
      INCORRECT_RESPONSE = 
        config.getServletContext().getInitParameter("INCORRECT_RESPONSE");
    }
    this.context = getServletContext();
  }
  
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    String answer = req.getParameter("answer").trim();
    String poem = req.getParameter("poem");
    String filepath = this.context.getRealPath(this.POEMS_DIRECTORY + poem);
    Boolean correct = Boolean.valueOf(false);
    
    Integer line = Integer.valueOf(Integer.parseInt(req.getParameter("line")));
    
    String xpathcorrect = "string-join(//TEI:l[@n='" + line + "']/TEI:seg,'|')";
    log("Using xpath " + xpathcorrect);
    
    log("Reading " + filepath);
    System.setProperty("javax.xml.xpath.XPathFactory:http://saxon.sf.net/jaxp/xpath/om", 
    
      "net.sf.saxon.xpath.XPathFactoryImpl");
    IndependentContext xpathcontext = new IndependentContext(
      new Configuration());
    xpathcontext.declareNamespace("TEI", "http://www.tei-c.org/ns/1.0");
    XPathEvaluator xp = new XPathEvaluator();
    
    xp.setNamespaceContext(new NamespaceContextImpl(
      xpathcontext.getNamespaceResolver()));
    try
    {
      String realanswer = xp.evaluate(xpathcorrect, new InputSource(new FileInputStream(filepath)));
      if (answer.equals(realanswer))
      {
        log("The proffered answer was: " + answer + 
          ", and the correct answer was indeed " + realanswer);
        correct = Boolean.valueOf(true);
      }
      else
      {
        log("The proffered answer was: " + answer + 
          " and the correct answer was " + realanswer);
      }
    }
    catch (XPathExpressionException e)
    {
      log(e.toString(), e);
      e.printStackTrace();
    }
    if (correct.booleanValue()) {
      resp.sendRedirect(CORRECT_RESPONSE);
    } else {
      resp.sendRedirect(INCORRECT_RESPONSE);
    }
  }
}
