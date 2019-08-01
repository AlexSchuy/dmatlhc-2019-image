FROM hepstore/rivet:2.7.2
RUN pip install numpy scipy
RUN ["/bin/bash", "-c", "wget https://launchpad.net/mg5amcnlo/2.0/2.6.x/+download/MG5_aMC_v2.6.6.tar.gz"]
RUN ["/bin/bash", "-c", "tar -xzf MG5_aMC_v2.6.6.tar.gz; rm MG5_aMC_v2.6.6.tar.gz; mv MG5_aMC_v2_6_6 madgraph"]
RUN cd madgraph; echo "install pythia8" >> install.dat; ./bin/mg5_aMC install.dat; rm install.dat
RUN cd madgraph; echo "install ninja" >> install.dat; echo "install collier" >> install.dat; echo "install oneloop" >> install.dat; echo "install looptools" >> install.dat; echo "install QCDLoop" >> install.dat; ./bin/mg5_aMC install.dat; rm install.dat
RUN cd madgraph/vendor/CutTools; make clean; make
RUN cd madgraph/vendor/IREGI/src; make clean; make
RUN wget "http://home.thep.lu.se/~torbjorn/pythia8/pythia8212.tgz"; tar -xzf pythia8212.tgz; rm pythia8212.tgz; mv pythia8212 pythia8
RUN cd pythia8; ./configure --with-hepmc2=/work/madgraph/HEPTools/hepmc --with-lhapdf6=/work/madgraph/HEPTools/lhapdf6 --with-boost=/work/madgraph/HEPTools/boost; make;
RUN cd pythia8/examples; make main42; mv main42 /usr/local/bin/pythia_example
RUN echo "export PYTHONPATH=/work/madgraph/HEPTools/lhapdf6/lib/python2.7/site-packages:$PYTHONPATH" >> ~/.bashrc; echo "export LD_LIBRARY_PATH=/work/madgraph/HEPTools/lhapdf6/lib:$LD_LIBRARY_PATH" >> ~/.bashrc; echo "export PATH=/work/madgraph/bin:$PATH" >> ~/.bashrc; echo "export RIVET_ANALYSIS=ATLAS_2017_I1609448" >> ~/.bashrc
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
COPY DMsimp_s_spin1.tar .
RUN tar -xvf DMsimp_s_spin1.tar; mv DMsimp_s_spin1 madgraph/models/; rm DMsimp_s_spin1.tar
COPY pythia.tmpl .
COPY make_pythia_card.py .
COPY yoda2json.py .
