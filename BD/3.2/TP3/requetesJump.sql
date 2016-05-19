select ST_Area(the_geom) from parcs ;
select ST_Area(the_geom), ST_Perimeter(the_geom) from buildings where type='public' ;
select citizens.name from citizens, parcs where ST_Contains(parcs.the_geom, citizens.the_geom) ;
select count(citizens.name) from citizens, buildings, parcs where ST_Contains(parcs.the_geom, citizens.the_geom) and citizens.id = buildings.owner_id ;
select citizens.name from citizens, buildings, parcs where ST_Contains(parcs.the_geom, citizens.the_geom) and citizens.id = buildings.owner_id ;
select a.name , b.name ,ST_Distance(a.the_geom,b.the_geom) from buildings a , buildings b where a.id > b.id and a.type = 'prive' and b.type = 'prive' ;
select ST_StartPoint(the_geom), ST_EndPoint(the_geom) from roads where name = 'Rue Inconnue' ;
select a.name , b.name , ST_Intersection(a.the_geom, b.the_geom) from roads a , roads b where ST_Intersects(a.the_geom , b.the_geom) and a.type= 'principale' and b.type='secondaire' ;
select a.name , b.name from citizens a , buildings b where a.name = 'Gunhild' and ST_Distance(a.the_geom , b.the_geom) = (select min(ST_Distance(c.the_geom,d.the_geom)) from citizens c , buildings d where c.name = 'Gunhild' ) ;
select buildings.name from citizens, buildings where not ST_Contains(buildings.the_geom, citizens.the_geom) ;
select buildings.name from buildings except (select distinct buildings.name from citizens, buildings where ST_Contains(buildings.the_geom, citizens.the_geom)) ;
e
