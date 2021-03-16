Macro: Macro can be used for replacement of heavy blocks of code with single lines.

Macro Declaration:- 

    %macro {macroName} {No of macro arguments}
        {statements to be executed} 
    %endmacro    

Macro Call:-

    {macroname} {arguments separated by ','}

Macro Under the Hood:-
1. Macro replaces the macro exection statement with the code in the definition.

2. Macro increases the time and space complexity.