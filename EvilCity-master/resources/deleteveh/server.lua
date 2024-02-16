-- Add an event handler for the 'chatMessage' event
AddEventHandler( 'chatMessage', function( source, n, msg )  

    msg = string.lower( msg )
    
    -- Check to see if a client typed in /dv
    if ( msg == "/dv" or msg == "/delv" ) then 
    
        -- Cancel the chat message event (stop the server from posting the message)
        CancelEvent() 

        -- Trigger the client event 
        TriggerClientEvent( 'deleteVehicle', source )
    end
end )