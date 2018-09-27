import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow
           "spiro"     -- window title
        (800, 600)   -- window size
        (300, 150))    -- window position
    black            -- background color
    spiro          -- picture to display

cerise = light $ light $ makeColorI 255 7 79 255
darkblue = light $ light $ makeColorI 0 0 153 255

spiro :: Picture
spiro = pictures $ drawCircle 100 0

toRad :: Float -> Float
toRad angle = angle * pi / 180

drawCircle :: Float -> Float -> [Picture]
drawCircle radius angle
    | angle >= 360.0 = []
    | otherwise      = (translate x y $ color mixed $ Circle 160) : (drawCircle radius (angle + step))
        where 
            x = radius * (cos $ toRad angle)
            y = radius * (sin $ toRad angle)
            step = 360 / 50
            mixed = mixColors angle (360 - angle) cerise darkblue
