/* 
 **********************************************************************
 *
 * $Id: NoPrefaceException.java,v 1.2 2011/01/04 10:41:20 vizigoth Exp $
 *
 * The contents of this file are subject to the AAF SDK Public
 * Source License Agreement (the "License"); You may not use this file
 * except in compliance with the License.  The License is available in
 * AAFSDKPSL.TXT, or you may obtain a copy of the License from the AAF
 * Association or its successor.
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.  See
 * the License for the specific language governing rights and 
 * limitations under the License.
 *
 * The Original Code of this file is Copyright 2007, Licensor of the
 * AAF Association.
 *
 * The Initial Developer of the Original Code of this file and the 
 * Licensor of the AAF Association is Richard Cartwright.
 * All rights reserved.
 *
 * Contributors and Additional Licensors of the AAF Association:
 * Avid Technology, Metaglue Corporation, British Broadcasting Corporation
 *
 **********************************************************************
 */

/*
 * $Log: NoPrefaceException.java,v $
 * Revision 1.2  2011/01/04 10:41:20  vizigoth
 * Refactor all package names to simpler forms more consistent with typical Java usage.
 *
 * Revision 1.1  2009/03/30 09:04:59  vizigoth
 * Refactor to use SMPTE harmonized names and add early KLV file support.
 *
 * Revision 1.2  2007/11/27 20:38:10  vizigoth
 * Edited javadoc comments to release standard.
 *
 * Revision 1.1  2007/11/13 22:10:15  vizigoth
 * Public release of MAJ API.
 */

package tv.amwa.maj.exception;

// TODO References: AAFFile - consider removing?

/** 
 * <p>Thrown when a file does not contain a {@linkplain tv.amwa.maj.model.Preface preface} 
 * object.</p>
 * 
 * <p>No equivalent C result code has been found.</p>
 * 
 * @see tv.amwa.maj.model.Preface
 *
 * @author <a href="mailto:richard@portability4media.com">Richard Cartwright</a>
 *
 */
public class NoPrefaceException 
	extends RuntimeException 
	implements MAJException {

	/** <p></p> */
	private static final long serialVersionUID = 2632228164655513843L;

	/**
	 * <p>Create a new no preface exception with the given descriptive message.</p>
	 * 
	 * @param msg Message describing the exception.
	 */

	public NoPrefaceException(
			String msg) {
		
		super(msg);
	}
	
	/**
	 * <p>Create a new no preface exception with no message.</p>
	 */
	public NoPrefaceException() {
		super();
	}
}