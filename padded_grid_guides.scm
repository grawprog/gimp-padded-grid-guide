 
; -*-scheme-*-
; Graw 2021. No copyright.  Public Domain.  
; Script based on NewGuidesXPixels by Nicholas DeClario

(define (script-fu-guide-graw image
			     drawable
			     xoffset
			     yoffset
			     xsize
			     ysize
			     xpadding
			     ypadding)
    (let* (
		(width (car (gimp-image-width image)))
		(height (car (gimp-image-height image)))
		(xposition xoffset)
		(yposition yoffset)
		(xend (- width xoffset))
		(yend (- height yoffset))
		(imgsize width)
          )
    
    (gimp-image-undo-group-start image)
    (gimp-image-add-hguide image yoffset)
    (gimp-image-add-vguide image xoffset)
    (gimp-image-add-hguide image yend)
    (gimp-image-add-vguide image xend)
    
    (while (< (+ xposition xsize) (- width xoffset))
	    (set! xposition (+ xsize xposition))
	    (gimp-image-add-vguide image xposition)
	    (when (> xpadding  0)
            	(set! xposition (+ xpadding xposition))
            	(gimp-image-add-vguide image xposition))
    )  
    (while (< (+ yposition ysize) (- height yoffset))
        (set! yposition (+ ysize yposition))
	    (gimp-image-add-hguide image yposition)
	    (when (> ypadding 0)
            	(set! yposition (+ ypadding yposition))
            	(gimp-image-add-hguide image yposition))
    )
    
    

    (gimp-image-undo-group-end image)
    (gimp-displays-flush)
  )
)

(script-fu-register "script-fu-guide-graw"
  _"Padded Grid of Guides"
  "Adds a grid of guides starting from an offset with padding between cells."
  "Graw"
  "Graw 2021"
  "July 2021"
  ""
  SF-IMAGE      "Input Image"      0
  SF-DRAWABLE   "Input Drawable"   0
  SF-ADJUSTMENT _"X Offset (pixels)"        '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT _"Y Offset (pixels)"        '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT _"X Cell Size (pixels)"        '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT _"Y Cell Size (pixels)"        '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT _"X Padding (pixels)"        '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT _"Y Padding (pixels)"        '(0 0 10000 1 10 0 1)
  
)

(script-fu-menu-register "script-fu-guide-graw"
                         "<Image>/Image/Guides")
