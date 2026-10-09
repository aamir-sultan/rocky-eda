FROM rockylinux:9

# RUN dnf config-manager --enable crb && \
#     dnf makecache
RUN dnf -y update && \
    dnf -y install epel-release

RUN dnf -y install xclock && \
    dnf -y install git && \
    dnf -y install sudo && \
    dnf -y install java && \
    dnf clean all
# Create a non-root user (replace 'myuser' with your choice)
# -m creates the home directory, -G adds them to the wheel group
RUN useradd -m -G wheel r2d2

# Optional: Allow the wheel group to use sudo without a password
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel

# Set the default user for the container
USER r2d2
WORKDIR /home/r2d2

RUN cd && git clone https://github.com/aamir-sultan/dots .dots
RUN cd .dots && ./install.sh --all
    
# CMD ["/usr/bin/xclock"]
