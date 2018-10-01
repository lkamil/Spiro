import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow "spiro"     -- window title
        (600, 500)            -- window size
        (300, 150))           -- window position
    black   -- background color
    spiro   -- picture to display

-- parameters
innerRadius = 56    -- radius of the inner circle
outerRadius = 57    -- radius of the outer circle
distance    = 130   -- distance from the centre of the inner circle
loops       = 40    -- count of 360° loops
density     = 2000  -- higher density results in smoother lines

-- spiro combines different trochoids
spiro :: Picture
spiro = pictures
    [ color darkred $ line drawHypotrochoid
    , color rosee $ line drawHypocycloid
    , color lightgreen $ line drawEpicycloid
    , color darkblue $ line drawEpitrochoid
    ]

-- colors
cerise = light $ makeColorI 255 7 79 255
purple = light $ light $ makeColorI 0 0 153 255
citrone = makeColorI 255 232 0 255
lightgreen = makeColorI 0 153 153 255
skin = makeColorI 255 204 153 255
darkblue = makeColorI 0 80 221 255
rosee = makeColorI 255 102 153 255
babyblue = makeColorI 115 254 255 255
darkred = makeColorI 153 0 36 255
darkpurple = makeColorI 38 0 77 255

drawHypotrochoid = drawHypotrochoidH (0, 0) 0
drawHypocycloid = drawHypocycloidH (0, 0) 0
drawEpitrochoid = drawEpitrochoidH (0, 0) 0
drawEpicycloid = drawEpicycloidH (0, 0) 0

drawHypotrochoidH :: Point -> Float -> Path
drawHypotrochoidH (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawHypotrochoidH (newX, newY) (angle + step)
    where
        newX = (outerRadius - innerRadius) * (cos $ toRad angle) + distance * (cos (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius - innerRadius) * (sin $ toRad angle) - distance * (sin (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawEpicycloidH :: Point -> Float -> Path
drawEpicycloidH (lpx, lpy) angle
    | angle >=  360 * loops= []
    | otherwise = (newX, newY) : drawEpicycloidH (newX, newY) (angle + step)
    where
        newX = (outerRadius + innerRadius) * (cos $ toRad angle) - innerRadius * (cos (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius + innerRadius) * (sin $ toRad angle) - innerRadius * (sin (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawHypocycloidH :: Point -> Float -> Path
drawHypocycloidH (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawHypocycloidH (newX, newY) (angle + step)
    where
        newX = (outerRadius - innerRadius) * (cos $ toRad angle) + innerRadius * (cos (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius - innerRadius) * (sin $ toRad angle) - innerRadius * (sin (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawEpitrochoidH :: Point -> Float -> Path
drawEpitrochoidH (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawEpitrochoidH (newX, newY) (angle + step)
    where
        newX = (outerRadius + innerRadius) * (cos $ toRad angle) + distance * (cos (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius + innerRadius) * (sin $ toRad angle) - distance * (sin (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

toRad :: Float -> Float
toRad angle = angle * pi / 180
