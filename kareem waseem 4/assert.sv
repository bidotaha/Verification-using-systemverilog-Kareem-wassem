module assert ();
    
    property test1;
    (@(posedge clk) a |-> ##2 b);
    endproperty
    assert property (test1);
    cover property (test1);

    property test2;
    (@(posedge clk) (a&&b) |=>  ##[1:3] c);
    endproperty
    assert property (test2);
    cover property (test2);

    sequence s11b;
     ##2 !b;
    endsequence

    property test3;
    (@(posedge clk) ($onehot(Y) == 1));
    endproperty
    assert property (test3);
    cover property (test3); 

    property test4;
    (@(posedge clk) (d == 4'b0000) |=> ##1 !valid);
    endproperty
    assert property (test4);
    cover property (test4);    

endmodule