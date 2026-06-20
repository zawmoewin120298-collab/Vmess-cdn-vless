FROM jc21/nginx-proxy-manager:latest

# Railway ၏ ပတ်ဝန်းကျင်အတွက် လိုအပ်သော ခွင့်ပြုချက်များ ပေးခြင်း
USER root

# Railway က သတ်မှတ်ပေးမည့် Dynamic Port ကို လက်ခံရန်နှင့် 
# NPM Admin Dashboard ကို Port 81 အစား 7860 (သို့မဟုတ် Railway ပေးသော Port) တွင် Run စေရန်
ENV PORT=7860
EXPOSE 7860

# Docker Storage အတွက် လိုအပ်သော Folder များ ဆောက်ခြင်း
RUN mkdir -p /data /etc/letsencrypt

# NPM ကို စတင်မောင်းနှင်ရန်
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
