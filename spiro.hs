import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow
           "spiro"     -- window title
        (800, 600)   -- window size
        (300, 150))    -- window position
    white            -- background color
    spiro          -- picture to display

spiro :: Picture
spiro = pictures $ drawCircle 100 0

toRad :: Float -> Float
toRad angle = angle * pi / 180


drawCircle :: Float -> Float -> [Picture]
drawCircle radius angle
    | angle >= 360.0 = []
    | otherwise      = (translate x y $ Circle 150) : (drawCircle radius (angle + step))
        where 
            x = radius * (cos $ toRad angle)
            y = radius * (sin $ toRad angle)
            step = 360 / 50
