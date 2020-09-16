# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

#------------------------------------------------------------------
# set PATH variable
#------------------------------------------------------------------
#export PATH=$PATH:"~/etc:/opt/bin:~/tools::\
#              ~/local/festival/bin:\
#              ~/local/speech_tools/bin:\
#			  /opt/bin:\
#              ${PATH}:\
#              /sbin"

export PATH=$PATH:/usr/local/SPTK-3.9/bin:
export PATH=$PATH:/usr/local/HTS-2.3/bin:
export PATH=$PATH:/usr/local/MATLAB/R2012a/bin/:
			
#export PYTHONPATH=/usr/bin/:$scripting/src/tools:$scripting/scitools/lib
#/usr/local/ActivePython2.4/bin:\

# Set PATH so it includes user's private bin if it exists
			 if [ -d ~/bin ] ; then
			   PATH="~/bin:${PATH}"
			   fi
# Set MANPATH so it includes users' private man if it exists
			   if [ -d ~/man ]; then
			     MANPATH="~/man:${MANPATH}"
				 fi
# Set INFOPATH so it includes users' private info if it exists
				 if [ -d ~/info ]; then
				   INFOPATH="~/info:${INFOPATH}"
				   fi
