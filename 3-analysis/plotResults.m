
resDir=getenv('RES_DIR');

x = dataset('file', strcat(resDir,'/res-MAIN-PREG-',num2str(sensitivity),'.csv'), 'delimiter', '\t');
keepidxX = cellfun('isempty',strfind(x.test1, '-adj'));
x = x(~keepidxX,:);
ximp = dataset('file', strcat(resDir,'/res-IMPUTED-PREG-',num2str(sensitivity),'.csv'), 'delimiter', '\t');
keepidxXimp = cellfun('isempty',strfind(ximp.test1, '-adj'));
ximp = ximp(~keepidxXimp,:);
x = [x;ximp];

x


fontsizex = 9;


%%%%
%%%% results in terms of 1 unit change of outcome


h=figure();
set(gcf,'position',[100,100,250,500])
plot([0 22], [0 0], '--', 'color', 'black');
xlim([0 10]);
ylim([-0.02 0.1])
set(gca,'fontsize',fontsizex);
rotateXLabels(gca, 65);
xlabel('Summary variable');
ylabel('Mean difference in summary variable per 1kg/m\^2 higher BMI');


% add results

[p1, p2] = myplot(x, 'meanaucperday', 1);
myplot(x, 'meanaucperday_dt', 2);
myplot(x, 'meanaucperday_nt', 3);
myplot(x, 'meanfastingproxy', 5);
myplot(x, 'mean_meal_pp1', 7);
myplot(x, 'mean_meal_pp2', 9);

fieldLabels = {'Mean AUC per minute (mmol/L)', 'Mean AUC per minute, day-time (mmol/L)', 'Mean AUC per minute, night-time (mmol/L)', 'Fasting proxy (mmol/L)', 'Post-prandial 1 hour AUC (mmol/L)', 'Post-prandial 2 hour AUC (mmol/L)' };


set(gca,'XTick',[1 2 3 5 7 9]+0.2);
set(gca,'XTickLabel',fieldLabels);


% finish figure
set(h,'Units','Inches');
pos = get(h,'Position');
legend([p1 p2], 'Complete days', 'Approximally adjusted', 'location', 'best');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
saveas(h, strcat(resDir, '/res-all-outcomeunits',num2str(sensitivity),'.pdf'));





%%%%
%%%% results in terms of % change of outcome


h=figure();
set(gcf,'position',[100,100,400,500])
plot([0 22], [0 0], '--', 'color', 'black');
xlim([0 22]);
set(gca,'fontsize',fontsizex);
rotateXLabels(gca, 65);
xlabel('Summary variable');
ylabel('% difference in summary variable per 1kg/m\^2 higher BMI');


% add results

[p1, p2] = myplot(x, 'meanmadperdayLogLOG', 1);
myplot(x, 'meanmadperday_dtLogLOG', 2);
myplot(x, 'meanmadperday_ntLogLOG', 3);
myplot(x, 'meansgvpperdayLogLOG', 5);
myplot(x, 'meansgvpperday_dtLogLOG', 6);
myplot(x, 'meansgvpperday_ntLogLOG', 7);

myplot(x, 'meanproportionlowperday', 9);
myplot(x, 'meanproportionlowperday_dt', 10);
myplot(x, 'meanproportionlowperday_nt', 11);
myplot(x, 'meanproportionnormalperday', 13);
myplot(x, 'meanproportionnormalperday_dt', 14);
myplot(x, 'meanproportionnormalperday_nt', 15);
myplot(x, 'meanproportionhighperday', 17);
myplot(x, 'meanproportionhighperday_dt', 18);
myplot(x, 'meanproportionhighperday_nt', 19);


myplot(x, 'mean_meal_timetopeakLogLOG', 21);

fieldLabels = {'MAD', 'MAD, day-time', 'MAD, night-time', 'sGVP', 'sGVP, day-time', 'sGVP, night-time', 'Time in hypo-glycaemia', 'Time in hypo-glycaemia, day-time', 'Time in hypo-glycaemia, night-time', 'Time in normo-glycaemia', 'Time in normo-glycaemia, day-time', 'Time in normo-glycaemia, night-time','Time in hyper-glycaemia', 'Time in hyper-glycaemia, day-time', 'Time in hyper-glycaemia, night-time', 'Mean post-prandial time to peak'};

set(gca,'XTick',[1 2 3 5 6 7 9 10 11 13 14 15 17 18 19 21]+0.2);
set(gca,'XTickLabel',fieldLabels);

% finish figure
set(h,'Units','Inches');
pos = get(h,'Position');
legend([p1 p2], 'Complete days', 'Approximally adjusted', 'location', 'best');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
saveas(h, strcat(resDir, '/res-all-percent',num2str(sensitivity),'.pdf'));



