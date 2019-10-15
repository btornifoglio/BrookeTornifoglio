function [letter] = Alphabet(number)
%%returns a letter that correponds to the number of column in an excel
%%file

alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

if (number <= 26)
    letter = alpha(number);
else
    quot = number./26;
    first = floor(quot);
    second = rem(number,26);
    if second==0
        first = first-1;
        second = 26;
    end
    letter =[alpha(first),alpha(second)];
end