FROM centos 

RUN yum -y install epel-release && \ 
    yum install -y supervisor xrdp && \
    yum clean all

RUN yum group install -y  xfce && \
    yum -y install firefox pm-utils

COPY etc/yum.repos.d/ /etc/yum.repos.d/

RUN rpm --import https://duo.com/RPM-GPG-KEY-DUO && \
    yum install -y  duo_unix && \
    yum clean all 

# http://sigkillit.com/2013/02/26/how-to-remotely-access-linux-from-windows/
COPY etc/ /etc/

# Allow all users to connect via RDP.
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

EXPOSE 3389 
CMD ["supervisord", "-n"]

