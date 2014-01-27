function exp2
    %vidFile = 'F:\SPBSU\Masters\EVM_Matlab\data\warped.avi';
<<<<<<< HEAD
    vidFile = 'F:\SPBSU\Masters\EVM_Matlab\data\3779_cut1.mp4';
=======
    vidFile = 'C:\Users\admin\Desktop\Google Drive\Grad School\Master''s\CanonVideos\Maria\3780_cut2.mp4';
>>>>>>> ef46bc09573147a52d59f7933848786063488436

    % Read video
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    fr = vid.FrameRate;
    len = vid.NumberOfFrames;
    
    vid = VideoReader(vidFile);
    % Extract video info
    vidHeight = vid.Height;
    vidWidth = vid.Width;
    nChannels = 3;
    temp = struct('cdata', zeros(vidHeight, vidWidth, nChannels, 'uint8'), 'colormap', []);

    % firstFrame
    temp.cdata = read(vid, 1);
    [rgbframe, ~] = frame2im(temp);
    rgbframe = im2double(rgbframe);
<<<<<<< HEAD
    intervalx = [250:800];
    intervaly = [650:1200];
=======
    intervalx = [135:600];
    intervaly = [400:800];
>>>>>>> ef46bc09573147a52d59f7933848786063488436
    rgbframe = rgbframe(intervalx, intervaly, 1:3);
    rgbframe = rgb2gray(rgbframe);
    
    % set optical flow parameters (see Coarse2FineTwoFrames.m for the definition of the parameters)
    alpha = 0.012;
    ratio = 0.75;
    minWidth = 20;
    nOuterFPIterations = 7;
    nInnerFPIterations = 1;
    nSORIterations = 30;

    para = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];
    
<<<<<<< HEAD
    outName = '.\output\data3780_cut2_stab.mp4';
=======
    outName = '.\output\3780_cut2_stab.avi';
>>>>>>> ef46bc09573147a52d59f7933848786063488436
    
    vidOut = VideoWriter(outName);
    vidOut.FrameRate = fr;

    open(vidOut);

    
    vx_cur = zeros(size(rgbframe,1), size(rgbframe, 2));
    vy_cur = zeros(size(vx_cur));    
    for i = 1:len
        temp.cdata = read(vid, i);
        [rgbframe2, ~] = frame2im(temp);
        rgbframe2 = im2double(rgbframe2);
        rgbframe2 = rgbframe2(intervalx, intervaly, 1:3);
        rgbframe2gr = rgb2gray(rgbframe2);
        [vx,vy,warpI2] = Coarse2FineTwoFrames(rgbframe,rgbframe2gr,para);        
        sz = size(rgbframe);
        [y x] = ndgrid( 1:sz(1), 1:sz(2) );
        px = round(x+vx);
        py = round(y+vy);        
        vx_cur = interp2(x, y, vx_cur, px, py, 'linear', 0);
        vx_cur = vx_cur + vx;
        
        vy_cur = interp2(x, y, vy_cur, px, py, 'linear', 0);
        vy_cur = vy_cur + vy;
        if (sum(sum(isnan(vx_cur))) > 0)
            vx_cur;
        end
        timg2(:, :, 1) = interp2( x, y, rgbframe2(:, :, 1), x+vx_cur, y+vy_cur);
        timg2(:, :, 2) = interp2( x, y, rgbframe2(:, :, 2), x+vx_cur, y+vy_cur);
        timg2(:, :, 3) = interp2( x, y, rgbframe2(:, :, 3), x+vx_cur, y+vy_cur);
%        imwrite(timg2, ['frame' num2str(i) '.bmp']);
        norm(vx)
        writeVideo(vidOut,im2uint8(timg2));
        rgbframe = rgb2gray(rgbframe2);
        if (mod(i,10) == 0)
            i
        end
    end
    
    close(vidOut);
    
end