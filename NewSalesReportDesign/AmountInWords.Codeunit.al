codeunit 50100 AmountInWords
{
    procedure ChangeToWords(amount: Decimal) str: Text
    var
        figInWords: Text;
        figAfterDecimalPoints: Text;
        words3: Text;
        tmp: Text;
        tmp1: Text;
        inputTmpTmp: Text;
        inputTmp: Text;
        input1Tmp: Text;
        input: Decimal;
        input1: Decimal;
        index: Integer;
        n: Decimal;
        i: Integer;
        j: Integer;
        figureTmp: Decimal;
        figure: Integer;
        list1: List of [Text];

    begin
        if (amount > 999999999999999.99) or (amount = 0.00) then begin
            str := '';
            exit(str);
        end;

        words3 := text3;

        //string solutions on amount(input) parameter, splitting it into two seperate values
        tmp := Format(Round(amount, 0.01, '='));
        list1 := tmp.Split('.');

        inputTmpTmp := list1.Get(1);

        if list1.Count > 1 then
            input1Tmp := list1.Get(2)
        else
            input1Tmp := '00';

        Evaluate(input, inputTmpTmp);
        Evaluate(input1, input1Tmp);

        index := 6;
        n := 1000000000000000.00;

        repeat
            index -= 1;
            n /= 1000.00;
        until
            (input / n) >= 1;

        for j := index downto 1 do begin
            figureTmp := input / n;
            figure := DecimalToInteger(figureTmp);

            if figure > 0 then begin
                if (figInWords <> '') and (j = 1) and ((input / 100) < 1) then
                    figInWords += ('and ' + HundredsInWords(figure))
                else
                    figInWords += (HundredsInWords(figure) + SelectStr(j, words3));
            end;
            input -= (figure * n);
            n /= 1000.00;
        end;

        figAfterDecimalPoints := DecimalFigureInWords(DecimalToInteger(input1));

        if (figInWords = '') and (figAfterDecimalPoints <> '') then begin
            str := figAfterDecimalPoints + ' kobo';
            exit(str);
        end
        else
            if (figInWords <> '') and (figAfterDecimalPoints = '') then begin
                str := figInWords + ' naira';
                exit(str);
            end
            else
                if (figInWords = '') and (figAfterDecimalPoints = '') then
                    exit(str)
                else begin
                    str := figInWords + ' naira ' + figAfterDecimalPoints + ' kobo';
                    exit(str);
                end;
    end;

    local procedure HundredsInWords(fig: Integer) str: Text
    var
        // str : Text;
        words1: Text;
        words2: Text;
        hundreds: Integer;
        fig1: Integer;
        fig2: Integer;
        fig3: Integer;
    begin
        words1 := text1;
        words2 := text2;
        hundreds := DecimalToInteger(fig / 100);
        fig1 := fig mod 100;
        fig2 := DecimalToInteger(fig1 / 10);
        fig3 := fig1 mod 10;

        if hundreds > 0 then begin
            str += (SelectStr(hundreds, words1) + ' hundred');
        end;
        if fig1 > 0 then //if we have figure after hundreds
            begin
            if fig1 > 19 then begin
                if hundreds > 0 then begin
                    if fig3 > 0 then
                        str += (' and ' + SelectStr(fig2, words2) + ' ' + SelectStr(fig3, words1))
                    else
                        str += (' and ' + SelectStr(fig2, words2));
                end
                else begin
                    if fig3 > 0 then
                        str += (SelectStr(fig2, words2) + ' ' + SelectStr(fig3, words1))
                    else
                        str += (SelectStr(fig2, words2));
                end;
            end;
            if (fig1 < 10) then begin
                if hundreds > 0 then
                    str += (' and ' + SelectStr(fig3, words1))
                else
                    str += (SelectStr(fig3, words1));
            end;
            if (fig1 > 9) and (fig1 < 20) then begin
                if hundreds > 0 then
                    str += (' and ' + SelectStr(fig1, words1))
                else
                    str += (SelectStr(fig1, words1));
            end;
        end;
        exit(str);
    end;

    local procedure DecimalFigureInWords(fig: Integer) str: Text
    var
        words1: Text;
        words2: Text;
        tens: Integer;
        fig1: Integer;
    begin
        words1 := text1;
        words2 := text2;

        if (fig > 0) then begin
            tens := DecimalToInteger(fig / 10);
            fig1 := fig mod 10;

            if (fig < 20) then
                str += SelectStr(fig, words1)
            else
                str += (SelectStr(tens, words2) + ' ' + SelectStr(fig1, words1));
        end;

        exit(str);
    end;

    local procedure DecimalToInteger(fig: Decimal) int: Integer
    var
        stringTem: Text;
        string: Text;
        toIntStr: Text;
        list1: List of [Text];

    begin
        stringTem := Format(fig);
        list1 := stringTem.Split('.');
        toIntStr := list1.Get(1);
        Evaluate(int, toIntStr);

        exit(int);
    end;

    var
        text1: Label 'one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,nineteen';
        text2: Label ',twenty,thirty,forty,fifty,sixty,seventy,eighty,ninety';
        text3: Label ', thousand , million , billion , trillion ';
}