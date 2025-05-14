module associate_array ();
     
     bit [23:0] assoc [bit[19:0]] ;

     initial begin
        assoc [0] = 24'hA50400;
        assoc [20'h400] = 24'h123456;
        assoc [20'h401] = 24'h789ABC;
        assoc [20'hF_FFFF] = 24'h0F1E2D;

        
        $display("the # of associate = %d ",assoc.num);

        foreach (assoc[i]) begin
            $display("assoc[%h] = %h ",i,assoc[i]);
        end
     end
endmodule