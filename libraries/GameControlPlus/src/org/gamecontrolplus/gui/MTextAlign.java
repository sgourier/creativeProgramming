/*
  Part of the GUI for Processing library 
  	http://www.lagers.org.uk/g4p/index.html
	http://gui4processing.googlecode.com/svn/trunk/

  Copyright (c) 2008-12 Peter Lager

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General
  Public License along with this library; if not, write to the
  Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA  02111-1307  USA
 */

package org.gamecontrolplus.gui;

import processing.core.PApplet;

/**
 * 
 * Is the basis for all classes that have some simple non-editable text element to them. <br>
 * 
 * @author Peter Lager
 * 
 */
public abstract class MTextAlign extends MTextBase {

	protected MAlign textAlignH = MAlign.CENTER, textAlignV =  MAlign.MIDDLE;
	
	protected float stX, stY;

	public MTextAlign(PApplet theApplet, float p0, float p1, float p2, float p3) {
		super(theApplet, p0, p1, p2, p3);
	}

	/**
	 * Set the horizontal and/or vertical text alignment. Use the constants in GAlign 
	 * e.g. <pre>GAlign.LEFT</pre> <br>
	 * 
	 * If you want to set just one of these then pass null in the other 
	 * 
	 * @param horz LEFT, CENTER, RIGHT or JUSTIFY
	 * @param vert TOP, MIDDLE, BOTTOM
	 */
	public void setTextAlign(MAlign horz, MAlign vert){
		if(horz != null && horz.isHorzAlign()){
			textAlignH = horz;
			stext.setJustify(textAlignH == MAlign.JUSTIFY);
		}
		if(vert != null && vert.isVertAlign()){
			textAlignV = vert;
		}
		bufferInvalid = true;
	}

	/**
	 * Combines setting the text and text alignment in one method. <br>
	 * 
	 * If you want to set just one of the alignments then pass null 
	 * in the other.
	 * 
	 * @param text
	 * @param horz LEFT, CENTER, RIGHT or JUSTIFY
	 * @param vert TOP, MIDDLE, BOTTOM
	 */
	public void setText(String text, MAlign horz, MAlign vert){
		setText(text);
		setTextAlign(horz, vert);
		bufferInvalid = true;
	}
	
	protected void calcAlignment(){
		switch(textAlignH){
		case RIGHT:
			stX = width - stext.getWrapWidth() - TPAD;
			break;
		case LEFT:
		case CENTER:
		case JUSTIFY:
		default:
			stX = TPAD;	
		}
		switch(textAlignV){
		case TOP:
			stY = TPAD;
			break;
		case BOTTOM:
			stY = height - stext.getTextAreaHeight() - TPAD;
			break;
		case MIDDLE:
		default:
			stY = (height - stext.getTextAreaHeight()) / 2;
		}
	}

}
