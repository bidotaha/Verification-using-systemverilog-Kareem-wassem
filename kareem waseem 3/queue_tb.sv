module queue_tb ();
    
    int j;
    int q[$];

    initial begin
        j = 1;
        q = '{0,2,5};
        $display(" queue = %p , j = %d ",q,j);

        q.insert (1,j);
        $display(" queue = %p , j = %d ",q,j);

        q.delete (1);
        $display(" queue = %p , j = %d ",q,j);

        q.push_front (7);
        $display(" queue = %p , j = %d ",q,j);

        q.push_back (9);
        $display(" queue = %p , j = %d ",q,j);

        j = q.pop_back();
        $display(" queue = %p , j = %d ",q,j);

        j = q.pop_front();
        $display(" queue = %p , j = %d ",q,j);

        q.reverse;
        $display(" queue = %p , j = %d ",q,j);

        q.sort;
        $display(" queue = %p , j = %d ",q,j);

        q.rsort;
        $display(" queue = %p , j = %d ",q,j);
        
        q.shuffle;
        $display(" queue = %p , j = %d ",q,j);
    end
endmodule