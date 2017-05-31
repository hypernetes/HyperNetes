(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �/Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[���1HB�u��	7�'��ʍ��4��|
�4M�(M"�w���(��4M#��1�R#?�9����vZ�}Y��v��\��(�G�O|?�������4^f2".�?E�d%�2��oS�_�C��_�,��w���叒$]ɿ\(����⊽u4\.��9�%���}��S���p��)�*���k��O'^���r�I�8
�"�;y?��{4%�B��Oj�#��?����ʽ������]��]�<�l�%l���(M�Iظ�E����OS$����Q����O�7�g��
?G�?��xQ��$�X���g�/5��������ؐ՚�}P��	���S�4]h�(�H��&��I����V���l5�M[�Ta&��~ʧ1�<�j���@.6�&h!�S�J�MJO��<�Mt��h�C����@O�{<e��t�����24H���ֶޗ�.��P�Ȗ(z9�����tj��
/=���ѿ)~i��^4]�~���c������R�Q�˸:��N���=^��(�cO�� V��<�����$�ڼ����7�n7�́P֔��'���e�ϚKq�"Zhsa���gݞ�	`ƅ����Y��i1o���h(ō :yNik�����֍��2ġ�i�<n��L���xYCrf�ԙsu0�O�m�w���q'�ǅ������b<j����)1�C�Aɕ��`!��C.��z�O�-A�(`~n�D�MSى�C�C�����������N���9�5�țr7�6�8Xs�*���f�b.�~�|������[K���
�4���6A(�(:�)( 2�T_#Bi���Ю/滑D���H���`��Ɗ�Q+S��_vЦ�6��0�Y�%C��#�w��f��9�[ݙ��\����� �������k�Q���N}��=/�����V�x.,)@�@�����u���(��EƤ����7+&@fK��(�t isy�1����R��(y��@����u��@.|[$�%���1�e�����}v�7��k�r�-'iKj����Ũ��,��Ez ǢϙE/�f�\�}X|`6<���,����i����D�������(���*��O�C)���2���������u�����Nݯv�zK qO��|h��x,fȑ8N�
��Q/!T�G��vB>$��N=��"��U�TA������^���i�$��h�o``a���x6ad1Ok�K��w��Dѭ\������5$B}ٚ8������ˇ��B�7�<6]�+�<s�y�i��}߁��{o��]~�-C��e[�*�ቪ{@k�(̶p-�#��4M93rր�6�����C�� �v~�d��Z.� ����>kr���r�Mwp�x/��-��))�D"�a�t�zr�a�:D��K}0�m�`B2���q���D���ϛX��X��P���o�m������}?��Z2��h�Y�!���:��x��_�������$U�����Ϝ�/����+�/��_�����������x9�(�T�_~I���S�������~}��>E8�b�P6[\� �H���0M���H@�.���Ca��(����U�?ʐ�+�ߏ�(����2pA�����IA+G�	�2�x���
� 4.�7�|x1�g-[�m[����r�45~��Ko�R��d3D��/9��g�A�ۑ���s���W����v+�j� �n���iX����4�?3����/%����+�_���j��Z����ޥ�?3����R�A����?��W��3����̡�H�>BaJo�vZ��?������|��,a��Y�c�gb>4����m����T8.Wy �Ȥ���L꽩4��s�m��{�;�9TD:FwE�z�ӹ��6֛ɼa�]c~��@�t��ʝ��1v���k̑��#�r68F$�{�����[�i��1K �L�0$�@ ��6PĖ �!/X��k�N8a7E�j�de:�� �n��;���GӞ=4�*���TQ��w{�χf=�/��$d�����f�u��LiYZw4�C^nvL5QBډI�H�,E�vC2�	\��d�Ѓ������%����?D��e�C���?�����������s�7��~�`��?�`���K��
Ϳ�����U�)��������\������=���Qť��+���ؤ�N?�0P>���v�����.�"K�$�"��"B�,J�$I�U���2�y�BShe�����T&��j�R��͉�1]0��cϑV�f?h�CO^��(���0�;uZI��!��h;��e>^�0�m�F9fl������#Bݞ��� ��|�q��g��Rrj��U��������~����(MT���������S�߱�CU������2�p��q��)x��$޾|Y9\.'�J�e�#���vЋ口Z��-����������O�����]��,F,�8�M��M��b��b������,����,��h�PTʐ���?8r<��Z��|\���Et�RKD�D�ń���6�F��w9W���i�~�~q�g5�	^�뺻�V��KQ=�#r�1v��2��-ptˇ`�Oe��4v��U뙈k���6H0{0��j��������v�w�]���w��P�xj�Q^�e������K��*��2��������o����2�Z�W���������]���X��a���ǳ�>�Y@���g�ݏ��{P����]P�z�F��=tw��ρnX�΁���~�9�Ѓ��6��2q�p��N�}1/�.���G��&1]���&�����k��4�Gx,�3��gr�CMf=Q'���7G����Q[x+.�K����Dӭ3�YO>�#ܖ�Q�2��8��n�u_;ms.���k ��ݚ�r.k)ZV�y:E��ڔ�9��t��nw�cC��B�w{�C ����䶷�<����à�bM p"�r65�y{WW\����Vd���Fg9�,3�V�֟��A��߃ j�;%6�NГr�&{+~f��ni���p�5��!��x����/m�����_
~���+��o�����Vn�o�2�����l�'�R����m�?���?�m�a��o��N2;M�p�g�?���qo(�g���@y�@wA޺d�d����5`�5M|��?�O΃���ɡ���-*�;��5Y/��Z�o�JOM���C|k�r�Z��0�SٌI2��u��(�Z"��r��դ��y��!�~��܇.���� ��Y>h��@�Dk�<�w�u7��+e0��j.uq�?%s9��V{f��!Wk����=h�t�0B��G�P��a�?������/q����T�W
~��|�Q��)	�1����ʐ�{�����Y����j��Z�������7��w�s���aX�����r�_n�]����U�g)��������\��-�(���O��o��r�'<¦iCI�b�d	��}�H�'p&@�vq�Q�!֧���u1�a0�:�B������/R������ �eJ���-sjư���S�m�m+[,�Fi�5yq��1��t�V�֕�FwGѽdMq=�o{;�cF��sh}�
��A~
ӻ�N���r���)�2�Q_��,6��y����bw�����8��������������Ū��*[?�
-����e~���~���\9^j�id����d������b:��N�+���c���B��k��^$������2��s%��UM�.�7<�iv��]���^�᧧&q�ξ��/!���_�:�7����Z6�]�����Q;�w]�*R����t��^���о/t�+���������jWN������w��U��N]�����G��%��}}�S���rmO�~z���bT���]ePQ��V�9O��2�n�]4��� �~�UQ����7D�.��ߐ�ӿK�}���F�+|;��������>w�z��8N����Q��E�g_nl��ߓ�o���7��d�y�,�3�^����o���:b��"{�a�%o�� ��w[/��������i]��Wv7�~Z���<���ϫ��g￟��c��_m�\T{X����q:�.�o�~��q���8��8K]8��'�PY?�n��v��&>ф�D����8���S�n�>*��~~ˇ#������NY��c������	d��
�8��!�"v�7�h�<.��#��:����M��3B�+�Ʒ�r��
��$����N�t��ϖ�u�p������q�*����vz.���b��m�-�����|8J'N2��8��R��8��ĉ=v�+�B*�b�?��
�� �� ?vQ+��C]!���� ��ēL���tz[�ϕ�8�{>|���y��9�X93Q��дoo�,6��Y�\�ܒ[@		���C!x�J��D,C����l�"k,��%2���X2JBk[׎�N�$�@l}a�/�������L�iQbѭ� l�Q Z�kB�1���g1�9'�p�	�B���ʢ��*�:���2�n��k�&�K��jM<4åv�L4�h �WG�0��K��#[F�v5�&�F㱩J��3u��ifX=��ߑ4�����s��A[ȗ�Y�����i	���X�{J���"Ι7��}0���37�UY=4��H�-����g�u�h[��F����[(��KSƪ�&jb�f܂�}s�5ESl=�bol4]�!�[4]h�p��N�fr�ԁӳ�i`	N��8��"8����i��N������u;�~SS�����NmUo?Jx����Z�F�5wY�='�t����4�I��8Q��]O؝��}�r��]vD��錮�/��	(#+�[���}����Q��hzC3�0�]梭,�>���u���>�|�T�Wr��c��öh?�1�.܄"7��V5JS�Q�ot��p�gI���-qAhIf�r��ӑkG�z!_OW�fK�&@���(���{E�9��RC���'i��~,IA�HDL���,!�V�C��2c�V�mI�2��޴.�D�[�&����a�;�؇��&���Vu�vagk��]G�#Xwu�܂.�`U�᧳O+xh6oEt�����4���Xw�j�q��/n��������s����	�"	���;��~��O}�.�=�J�xr�{����`
�!����z0�{�}?/�!�����8*�����pf�\4�w��ۻ/=t����ԃ�ܿ]x���?�/����"�`��8�t�s�]7�{G��F~�0 �qq䅇w�q��<|��k��-\���H�a���>;��~ /�JKF�9��ln����A\Rl^��Āͷ)s�uNZ<�$K��D!�� #�w~[���!r}ذ��	�z;�*P����z��W�vKh��h�W�b��~v�	�.�.a�AUZD +�u���Q�.��E��5����>g��%X�b��(���9��-\��T�o��`B��u4> dCf�<���p6̓3�U������e)���GC-��͔%�R*U_��/)٪e���L�#%��o��p�@���W�u���bD�����д�߬D2�����}ȗ/9LX�	�0a7a�"_>a�#&�2�"ltnSO�������蚟�R3B�`啕���#J	|#�mh����_'=�t(�V��Th�*4�*:4��?���\/i\�;���hO�i9��-o��Rh�q�鐕��=.�e���a��tc9�������G�d��
�����vQz�C{e2��:m��F1��F�����L �扆�'Qh9N�
�^k(��}��m��Mv?�,QjI��8�ی�;v�W_Y��,k6`]P�=on���]�$�Ψ`<
zS-�rű��
/9���=j��c�a-R��LGn3�R��=|��1��6���>s:e!9�-e����R��e\��u�̒�^�]�,q�GF�!��i��	�S��P� �Ӌ�ռ/�l�2�Y�2���A\Ç�=,�3�X#��\�8(���@"%��F��k�,�U�2\�,�㕥������@��ܫ	E���AH)Faxj�MK���.�?Բ��!Kc��QR��ս�B75�U�|�%��(�PZx
�)��%*�Jb#���� �qO6W8lIY�/ȮU.����B��zc�J]B��(���F��)��ϧ�l�C�8q���*=4ںХ�b�Wj��r,���j���t���S��9>��m��\"̀�����%��uyrm�Nd�B.����ع��y�U����#�₲o�˳�\�ϳ}�|UY������w�7��� �!v��E�G�wy���a�<�P�h}ʨJC! ���HA�.�(��;��IL!+]�a}�0�������c��H�m��h��j���=Vkr��������y����g�qٷ�;�*re�M��޾`�� ��M
`�W5���[�{��=��+��6[fzb^f�ו�|�:�Lj�I��_G~���+ҏ����@G�U��xf n�* �.+���lpv�m"hw�G�D^����~������`㗂�N�'���Mi�\�O��T�؉��|{����s_x�VGJfmu4��'����`<���y�W�.8X9����� g]pp�*`y�͚3��@���"%��m�Pho��*�a���>>�1^	�q.����T+8�:I,�b`iB���Ra�_�(��p�"^��m�ɦ�h���K�,U�L��ā��$3`�� ��KY�>����,i�ff8T"�H5��àGŽ�d.>> �f'5&X�Q��V��t +�Ǆ"=��jcG�e��>��zO��4�bkw<c��� !�;��G3�^�p�u�%�� ��c5�W[�Fy�M����v��1�8N�c=�^�#�۠S��9���M��3�i����=�<��p/r��p���<,��w��O̎��?<q���-�I{�D�6Drs��U���X�E�B��7	??"��D����<Z��MR�Eȅ��,&���
L�"�͚����x�X��3X�pz[KrF;H�:��±t���n��'�q�����\�W=!�dU��h+b0^_�T��8:q4[�(�����|0�h,�6r�J��"
���@H�_i�ݸ�@@{8��
Xܓ*��.jC|���"��A�*w�1)��u����iQ����s)���A���[�SK��otܐS{
�< ��iѨ6+�X��O��F�BK�.������co�q*�ǻ���)��)[ȱA�k���a����A+l�|�7�FG�u�����V�p�/0�7'�=�h���.�h�^�ܻ��ů��i��"���6� [�R.Nz���n�+�,�Q�&��q���a��7�����G~��^�g�c��������c/���?�����������9i1���~�u�����G�����mI�����W��[O��w��?�0r��'�<�����2�5�;�/"��_J�/&A<�u���[?������1�NԨ!;���%?t�����G[����ݾ?��������<��� �b�_�Q;�F^^�v�ҡv:�N������C�t��޿�:i' �P;j�C�t|6�g{=P;Oͷ��|�� UnB���zX䂦��h o[E�e<b��[ϙ:�c�?��?�yi��������8�R�O���1�8^3��8�g`�2��|�47�f���̙q��ΜgZ�3-��3��c�a�����a
�혙s��p��mJ�|uɣ�H�</~��A[���?'9�INr��6�7GP  