function [p1,p2,p3] = myplot(x, f, i)

colorx = {'[0.7 0.1 0.6]';'[0.5 0.8 0.0]';'[0.1 0.1 0.7]'};
markersx = {'o';'*';'s'};
markersizex = 7;
fontsizex = 9;


	% main
        test=1;
        i1 = find(strcmp(x.field, f)==1 & strcmp(x.test1, 'MAIN-PREG-adj')==1);
	if (size(i1,1) >0)
	        hold on; plot([i+0.1 i+0.1], [x.lower1(i1) x.upper1(i1)], '-', 'color', colorx{test}, 'linewidth', 3);
	        hold on; p1=plot(i+0.1, x.estimate1(i1), markersx{test}, 'color', colorx{test}, 'markersize', markersizex, 'MarkerEdgeColor', 'black');
	end

        % imputed approx
        test=2;
        i2 = find(strcmp(x.field, f)==1 & strcmp(x.test1, 'IMPUTED-APPROX-PREG-adj')==1);
	if (size(i2,1) >0)
	        hold on; plot([i+0.3 i+0.3], [x.lower1(i2) x.upper1(i2)], '-', 'color', colorx{test}, 'linewidth', 3);
	        hold on; p2=plot(i+0.3, x.estimate1(i2), markersx{test}, 'color', colorx{test}, 'markersize', markersizex, 'MarkerEdgeColor', 'black');
	end

	% imputed other
        test=3;
        i2 = find(strcmp(x.field, f)==1 & strcmp(x.test1, 'IMPUTED-OTHER-PREG-adj')==1);
        if (size(i2,1) >0)
                hold on; plot([i+0.5 i+0.5], [x.lower1(i2) x.upper1(i2)], '-', 'color', colorx{test}, 'linewidth', 3);
                hold on; p3=plot(i+0.5, x.estimate1(i2), markersx{test}, 'color', colorx{test}, 'markersize', markersizex, 'MarkerEdgeColor', 'black');
        end


end
