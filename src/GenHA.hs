module GenHA where

import HA
import Diagrams.Prelude
import BounceSim
import Maps
import Numeric           (showFFloat)

type Seg = (P2 Double, P2 Double)

loc1 = Location 1 "interior" "" "x'==vx &amp; y'==vy"
t1 = Transition 1 1 "e1" "guard" "assignment"


showN :: Double -> String
showN n = Numeric.showFFloat Nothing n ""

--mk_HA :: Poly V2 Double -> Angle Double -> HA
mk_pairs poly = let
    pts = (trailVertices . mapLoc cutTrail) poly
    mkpairs [] = []
    mkpairs [a] = []
    mkpairs (a:b:ls) = (a,b):(mkpairs (b:ls))
    in mkpairs pts

-- needs DSL
mkGuard :: Seg -> String
mkGuard (pt1, pt2) =
    let eps = 0.001
        (x1,y1) = unp2 pt1
        (x2,y2) = unp2 pt2
        dist1 (x,y) = "("++(showN x)++" -x)*("++(showN x)++" -x) + ("++(showN y)++" -y)*("++(showN y)++"-y)"
        dist2 (xi,yi) (xj, yj) = "("++(showN xi)++" -("++(showN xj)++"))*\
                                 \("++(showN xi)++" -("++(showN xj)++"))+\
                                 \("++(showN yi)++" -("++(showN yj)++"))*\
                                 \("++(showN yi)++" -("++(showN yj)++"))"
    in  (dist1 (x1,y1))++" + "++(dist1 (x2,y2))++" - ("++(dist2 (x1,y1)
        (x2,y2))++") &lt;= "++(showN eps)++" &amp;&amp; "++
        (dist1 (x1,y1))++" + "++(dist1 (x2,y2))++" - ("++(dist2 (x1,y1)
        (x2,y2))++") &gt;= -"++(showN eps)++" &amp;&amp; "++
        (showN x1)++" &lt;= x &amp;&amp; "++
        (showN x2)++" &gt;= x &amp;&amp; "++
        (showN y1)++" &lt;= y &amp;&amp; "++
        (showN y2)++" &gt;= y"


-- since we arbitrarily set |v| = 1, vx = cos(theta) and vy = sin(theta)
-- thus, when we update theta to theta_edge + theta_controller, we can use the
-- sin and cosine sum rules to compute new vx, vy without using inverse trig
mkAssign :: Angle Double -> Seg -> Assignment
mkAssign theta (pt1, pt2) = let
    (x1,y1) = unp2 pt1
    (x2,y2) = unp2 pt2
    len_e = sqrt ((y2-y1)^2 + (x2-x1)^2)
    sin_the = (y2-y1)/len_e
    cos_the = (x2-x1)/len_e
    theta' = (pi/2 -(theta ^. rad))
    cos_thc = cos theta'
    sin_thc = sin theta'
    cos_thout = cos_the*cos_thc - sin_the*sin_thc
    sin_thout = sin_the*cos_thc + cos_the*sin_thc
    in "vx := "++(showN cos_thout)++" &amp; vy := "++(showN sin_thout)


mkBounceTran :: Angle Double -> String -> Seg -> Transition
mkBounceTran theta label seg =
    let guard = mkGuard seg
        assign = mkAssign theta seg
    in Transition 1 1 label guard assign

mkBounceTrans :: Poly V2 Double -> Angle Double -> [Transition]
mkBounceTrans poly theta = let
    edges = mk_pairs poly
    n = length edges
    labels = mkLabels n
    in map (uncurry (mkBounceTran theta)) (zip labels edges)

mkLabels :: Int -> [String]
mkLabels n = map (\i -> "e"++(show i)) [1..n]

mkParams :: Poly V2 Double -> [Param]
mkParams poly = let
    dyn_params = [RealDyn "x", RealDyn "y", RealConst "vx", RealConst "vy"]
    edges = trailLocSegments poly
    n = length edges
    edge_params = map (\lab -> Lab lab) (mkLabels n)
    in dyn_params ++ edge_params
    

pt = p2 (1,1) :: P2 Double
pt1 = p2 (0,0) :: P2 Double
pt2 = p2 (2,2) :: P2 Double

vert1 = p2 (0, 2)

bounce_left = mkAssign (0 @@ rad) (pt1, vert1)

test_ha2 :: HA
test_ha2 = HA   { name = "test"
               , params = mkParams $ mkPoly sq
               , locations = [loc1]
               , transitions = mkBounceTrans (mkPoly sq) (0 @@ rad)
               }

test = write_HA test_ha2
