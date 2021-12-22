% RF Utilities_M
%
% Directory : RFutils_M
%                     |__DXF
%                     |__Examples
%                     |__QUCS
%              
%
% Note : Uses display routines in RFutils
%
% MAIN DIRECTORY
%
%   bmatch      - Calculates stepped transformer values (Chebyshev approximation).
%   binmatch    - Calculate Binomial (maximally flat) stepped transformer values.
%   bexp        - Calculate Exponential impedance taper.
%   btri        - Calculate Triangular impedance taper.
%   bklop       - Calculate Klopfenstein impedance taper.
%
%   bplot       - Analyse and plot response of bmatch,binmatch,bexp,btri or bklop output.
%   bdraw       - Add response curves to existing plot. 
%   bphysical   - Assign physical dimensions to a microstrip implementation.
%                 Also outputs a polygon file in .DXF format (using mat2dxfp).
%
%   bwilk       - Design multi-section Wilkinson divider.
%   chapprox    - Plots the Chebyschev approximation used by bmatch.
%   mat2dxfp    - Converts X,Y,Z coordinate arrays into polygons in DXF format.
%   setfname    - Sets the default filename for the .DXF file output, when
%                 the examples are run.
%
% DXF
%
%   Directory reserved for the .dxf files output by mat2dxfp 
%
%
% EXAMPLES
%
%   exb1/2/3/4  - Chebyshev approx stepped impedance transformers.
%   exbin1/2    - Binomial stepped impedance transformers 
%   ext1/2/3    - Chebyshev approx tapered line transfomers.
%   exk1/2      - Klopfenstein tapered line transformers.
%   exexp1      - Exponential taper transformer.
%   extri1      - Triangular taper transformer.
%   excomp1     - Comparison of Exp, Tri and Klop transformers.
%   exw1/2      - Examples of Wilkinson splitter design.
%
%   dxftest1    - 2D Example using the mat2dxfp fn
%   dxftest2    - 3D Example using the mat2dxfp fn
%
%   (All above examples have DXF output to match.dxf see setfname.m)
%
%
% QUCS (Quite Universal Circuit Simulator)
%
%   Contains model files for the Wilkinson splitter examples, using
%   the freely available QUCS software. 

% N.Tucker www.activefrance.com 2010