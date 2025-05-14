package pkg;
    class exercisel;
    rand [7:0] data ;
    rand [3:0] address ;
    constraint c_data {data == 5;}
    constraint c_address { address dist {0:=10,[1:14]/=80,15:=10};
       }

        function void print;
            $display("data_in = %b address = 0x%0h",this.data_in,this.address);
        endfunction //new()
    endclass / exercisel

endpackage 