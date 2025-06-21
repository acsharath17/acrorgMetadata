public with sharing class testMarkdown {
    public static void markdownHtml(string markdownContent){
        string gitHubToken = 'your_github_token'; // Replace with your GitHub token
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.github.com/markdown');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + gitHubToken);
        request.setHeader('X-GitHub-Api-Version', '2022-11-28');
        request.setHeader('Accept', 'application/vnd.github+json');
        //request.setTimeout(120000);
        Map<String, Object> payload = new Map<String, Object>{
            'text' => markdownContent
        };
        request.setBody(JSON.serialize(payload));
        HttpResponse response = http.send(request);
        system.debug('Markdown response---'+response.getBody());
    }
}