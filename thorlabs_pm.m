%THORLABS_PM Code for communicating with an instrument.
%
%   This is the machine generated representation of an instrument control
%   session. The instrument control session comprises all the steps you are
%   likely to take when communicating with your instrument. These steps are:
%   
%       1. Create an instrument object
%       2. Connect to the instrument
%       3. Configure properties
%       4. Write and read data
%       5. Disconnect from the instrument
% 
%   To run the instrument control session, type the name of the file,
%   thorlabs_pm, at the MATLAB command prompt.
% 
%   The file, THORLABS_PM.M must be on your MATLAB PATH. For additional information 
%   on setting your MATLAB PATH, type 'help addpath' at the MATLAB command 
%   prompt.
% 
%   Example:
%       thorlabs_pm;
% 
%   See also SERIAL, GPIB, TCPIP, UDP, VISA, BLUETOOTH.
% 
 
%   Creation time: 27-May-2019 16:46:19

% Find a VISA-USB object.
obj1 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1313::0x8079::P1000516::0::INSTR', 'Tag', '');

% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = visa('NI', 'USB0::0x1313::0x8079::P1000516::0::INSTR');
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);

% Disconnect all objects.
fclose(obj1);

% Clean up all objects.
delete(obj1);

