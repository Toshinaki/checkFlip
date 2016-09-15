function [  ] = checkFlip(  )
%CHECKFLIP Check if beampos is supported and timestamps are exact

% Take command window to front;
% when there're some error, use sca to close opened screen
commandwindow;

% Open a screen in default monitor
window = Screen('OpenWindow', 0);

% time from system start
t = GetSecs;
fprintf('\n[*] System started %d minutes ago. (%.6f seconds)\n', floor(t/60), t);

% test for how many time
trial_num = 5;

% Start loop
fprintf('\n%17s      |%19s    |%18s     | %12s | %10s |%9s  | %s \n', 'VBLTimestamp', 'StimulusOnsetTime', 'FlipTimestamp', 'VBL interval', 'Flip takes', 'Missed', 'Beampos');
for i = 1:trial_num
    [vbl, onset, fliptime, missed, beampos] = Screen('Flip', window);
    for ts = [vbl, onset, fliptime]
        t = num2str(ts, 16);
        fprintf('%ss;%sms;%s.%6s |', t(1:4), t(6:8), t(9:11), t(12:end));
    end
    vbli = (onset - vbl) * 1000;
    fliptake = (fliptime - vbl) * 1000;
    fprintf('  %.6fms  | %.6fms | %.6f | %d\n', vbli, fliptake, missed, beampos);
    
    WaitSecs(0.5);
end

if beampos >= 0
    fprintf('[*] Beampos accessible in your system. You are good to go!\n');
else
    fprintf('[!] Beampos not accessible; it is OK if time accuracy not important.\n')
end

sca;