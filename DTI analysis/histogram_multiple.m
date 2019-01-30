%histrorgams of two data sets
rng 'default'
data1 = md;
data2 = md_2;
edges = 0:.0001:.003;
h1 = histcounts(data1,edges,'Normalization','probability');
h2 = histcounts(data2,edges,'Normalization','probability');

figure
bar(edges(1:end-1),[h1; h2]')
legend({'Isotropic','Anisotropic'})
title('MD')
%% westin for 2 data sets
figure
plot(x, y,'*',x_2, y_2,'.')
xlim([0 1]); ylim([0 1]);
legend({'Isotropic','Anisotropic'})