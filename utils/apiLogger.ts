export const logApiRequest = (endpoint: string, method: string = 'GET') => {
  console.log(`🔄 API Request: ${method} ${endpoint}`);
};

export const logApiResponse = (endpoint: string, data: any, success: boolean = true) => {
  if (success) {
    console.log(`✅ API Success: ${endpoint}`);
    console.log(`📊 Response Data:`, JSON.stringify(data, null, 2));
  } else {
    console.log(`❌ API Error: ${endpoint}`);
    console.error(`📊 Error Data:`, data);
  }
};

export const logApiError = (endpoint: string, error: any) => {
  console.error(`❌ API Request Failed: ${endpoint}`);
  console.error(`📊 Error Details:`, error);
};