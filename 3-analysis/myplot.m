function [p1,p2] = myplot(x, f, i)

colorx = {'[0.7 0.1 0.7]';'[0.5 0.8 0.0]'};
markersx = {'o';'*'};
markersizex = 7;
fontsizex = 9;


	% main
        test=1;
        i1 = find(strcmp(x.field, f)==1 & strcmp(x.test1, 'MAIN-PREG-adj')==1);
	if (size(i1,1) >0)
	        hold on; plot([i+0.1 i+0.1], [x.lower1(i1) x.upper1(i1)], '-', 'color', colorx{test}, 'linewidth', 3);
	        hold on; p1=plot(i+0.1, x.estimate1(i1), markersx{test}, 'color', colorx{test}, 'markersize', markersizex, 'MarkerEdgeColor', 'black');
	end

        % imputed
        test=2;
        i2 = find(strcmp(x.field, f)==1 & strcmp(x.test1, 'IMPUTED-PREG-adj')==1);
	if (size(i2,1) >0)
	        hold on; plot([i+0.4 i+0.4], [x.lower1(i2) x.upper1(i2)], '-', 'color', colorx{test}, 'linewidth', 3);
	        hold on; p2=plot(i+0.4, x.estimate1(i2), markersx{test}, 'color', colorx{test}, 'markersize', markersizex, 'MarkerEdgeColor', 'black');
	end

end
