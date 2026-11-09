// ================================================================
// EXERCISE 5: IMAGE HISTOGRAM EQUALIZATION
// Note: Path need change according to the system path to work properly line 25
// Display:
//   Left column  : Original image + Original histogram
//   Right column : Equalized image + Equalized histogram.
// ================================================================

clear;
clc;

mprintf("\n========== EXERCISE 5: IMAGE PROCESSING ==========\n");

// Load IPCV toolbox.
// Install once from the Scilab console if necessary:
// atomsInstall("IPCV");

try
    atomsLoad("IPCV");
catch
    mprintf("Could not load IPCV. Check whether it is installed.\n");
end

// Change to right path !!!
imagePath  =  "C:/Users/DELL/Desktop/Lab_DSP/DSP-TN-CO2036/LAB 4/test_image.jpg";;

if isfile(imagePath) then

    try

        // --------------------------------------------------------
        // 1. READ IMAGE AND CONVERT TO GRAYSCALE
        // --------------------------------------------------------

        img = imread(imagePath);

        // Convert RGB image to grayscale.
        // Keep the image unchanged if it is already grayscale.
        if size(img, 3) >= 3 then

            imgDouble = double(img);

            grayImage = uint8(round( ...
                0.299 * imgDouble(:,:,1) + ..
                0.587 * imgDouble(:,:,2) + ..
                0.114 * imgDouble(:,:,3)));

        else

            grayImage = uint8(img);

        end

        grayDouble = double(grayImage);

        [numRows, numCols] = size(grayDouble);
        totalPixels = numRows * numCols;

        // --------------------------------------------------------
        // 2. CALCULATE ORIGINAL HISTOGRAM
        // --------------------------------------------------------

        histOriginal = zeros(1, 256);

        pixels = grayDouble(:);

        for level = 0:255
            histOriginal(level + 1) = sum(pixels == level);
        end

        // --------------------------------------------------------
        // 3. HISTOGRAM EQUALIZATION USING CDF
        // --------------------------------------------------------

        cdf = cumsum(histOriginal) / totalPixels;

        mapping = round(255 * cdf);
        mapping = min(255, max(0, mapping));

        // Apply the mapping to every pixel.
        equalizedVector = mapping(pixels + 1);

        equalizedDouble = matrix( ...
            equalizedVector, numRows, numCols);

        equalizedImage = uint8(equalizedDouble);

        // --------------------------------------------------------
        // 4. CALCULATE HISTOGRAM AFTER EQUALIZATION
        // --------------------------------------------------------

        histEqualized = zeros(1, 256);

        equalizedPixels = equalizedDouble(:);

        for level = 0:255
            histEqualized(level + 1) = ...
                sum(equalizedPixels == level);
        end

       
        // --------------------------------------------------------
        // 5. DISPLAY EVERYTHING IN ONE WINDOW
        // --------------------------------------------------------

        scf(5);
        clf();

        f = gcf();
        f.name = "Exercise 5 - Histogram Equalization";
        f.figure_size = [1200, 850];

        // Common X-axis ticks for both histograms.
        tickLocations = [0 64 128 192 255];
        tickLabels = ["0" "64" "128" "192" "255"];

        // ================= ORIGINAL IMAGE =======================

        subplot(2, 2, 1);

        Matplot(grayImage);

        imgHandle = gce();
        imgHandle.image_type = "gray";

        a = gca();
        a.isoview = "on";

        xtitle("Original Grayscale Image", "", "");

        // ================= ORIGINAL HISTOGRAM ===================

        subplot(2, 2, 3);

        // Use plot() instead of bar() to avoid 256 dense bar edges.
        plot(0:255, histOriginal);

        a = gca();
        a.x_ticks = tlist( ...
            ["ticks", "locations", "labels"], ...
            tickLocations, tickLabels);

        xgrid(5);

        xtitle( ...
            "Histogram Before Equalization", ...
            "Gray Level (0-255)", ...
            "Pixel Count");

        // ================= EQUALIZED IMAGE ======================

        subplot(2, 2, 2);

        Matplot(equalizedImage);

        imgHandle = gce();
        imgHandle.image_type = "gray";

        a = gca();
        a.isoview = "on";

        xtitle("Equalized Grayscale Image", "", "");

        // ================= EQUALIZED HISTOGRAM ==================

        subplot(2, 2, 4);

        plot(0:255, histEqualized);

        a = gca();
        a.x_ticks = tlist( ...
            ["ticks", "locations", "labels"], ...
            tickLocations, tickLabels);

        xgrid(5);

        xtitle( ...
            "Histogram After Equalization", ...
            "Gray Level (0-255)", ...
            "Pixel Count");

        // --------------------------------------------------------
        // 6. SAVE THE EQUALIZED IMAGE
        // --------------------------------------------------------

        outputPath = "lab4_ex5_equalized.png";
        imwrite(equalizedImage, outputPath);


        // --------------------------------------------------------
        // 7. DISPLAY RESULT INFORMATION
        // --------------------------------------------------------

        mprintf("\nExercise 5 completed successfully.\n");
        mprintf("Image loaded: %s\n", imagePath);
        mprintf("Image dimensions: %d x %d\n", numRows, numCols);
        mprintf("Total pixels: %d\n", totalPixels);
        mprintf("Equalized image saved as: %s\n", outputPath);

    catch

        mprintf("\nExercise 5 was not completed.\n");
        disp(lasterror(%t));

    end

else

    mprintf("Image file %s was not found.\n", imagePath);
    mprintf("Please check the image path.\n");

end
