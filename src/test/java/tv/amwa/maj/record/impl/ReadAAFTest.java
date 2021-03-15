package tv.amwa.maj.record.impl;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import tv.amwa.maj.extensions.avid.AvidFactory;
import tv.amwa.maj.industry.MediaEngine;
import tv.amwa.maj.io.aaf.AAFFactory;
import tv.amwa.maj.model.Preface;

import java.io.File;
import java.io.IOException;

public class ReadAAFTest
{
   @Before
   public void setUp() throws Exception
   {
      MediaEngine.initializeAAF();
      AvidFactory.registerAvidExtensions(); // registers AAF and common Avid extensions
   }

   @Test
   public void testS1SingleSample() throws IOException
   {
      test("StudioOne-SingleSample.aaf");
   }
   @Test
   public void testLogicPro() throws IOException
   {
      test("LogicPro.AAF");
   }

   void test(String filename) throws IOException
   {
      final File file = new File("test-data", filename);
      Assert.assertTrue(file.exists());

      Preface preface = AAFFactory.readPreface(file.getAbsolutePath());

      Assert.assertTrue(preface.getFormatVersion().getMajor() > 0);
   }
}
