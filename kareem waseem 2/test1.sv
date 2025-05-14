package my_package;
     
     class mem_trans;
     logic [7:0] data_in ;
     logic [3:0] address ;
        function new( logic [7:0] data_in = 0, logic [3:0] address = 0);
            this.data_in = data_in;
            this.address = address;
        endfunction

        function void print;
            $display("data_in = %b address = 0x%0h",this.data_in,this.address);
            
        endfunction
     endclass 
     


endpackage